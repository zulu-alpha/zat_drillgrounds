/*

    Author: Phoenix of Zulu-Alpha

    Description: Creates simple local helper sings at the given post with the given radius 
	             and returns a reference for each created object.

    Params:
		0: ARRAY - Position of center in ASL.
		1: NUMBER - Radius

    Returns:
		ARRAY - Of objects.

*/
params ["_center", "_radius"];

_center params ["_center_x", "_center_y", "_center_z"];

private _circle_objects = [
	createSimpleObject [
		"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
		[_center_x, _center_y, _center_z + 1],
		true
	]
];

/*

	We want 1 meter spacing between points on the perimeter
	We do this by determining how many degrees between points are needed to maintain a 1 
	meter perimeter spacing as the radius changes.

	perimeter = 2πr = P
	P/x = 1 -> where x is how many times we divide the perimeter to achieve a 1 meter slice.
	2πr / x = 1
	x = 2πr -> therefore we divide the circle up with the same number as the perimeter.

	So for example if we have a radius of 20, then to get the degrees of each slice:
	360 / 2π*20 = degrees
	360 / 126 = 2.86 degrees
	The perimeter gets rounded as we need to divide the 360 into discrete pieces

*/

if (_radius >= 1) then {
	private _perimeter = 2 * pi * _radius;
	// 360 must be divided by a discrete number in order to perfectly fit all the points.
	private _angle = 360 / (floor _perimeter); // perimeter can't be < 1
	
	for "_angle_i" from 0 to (360) step _angle do {
		_circle_objects pushBackUnique (
			createSimpleObject [
				"A3\Structures_F_Heli\VR\Helpers\Sign_sphere25cm_F.p3d",
				AGLtoASL [
					_radius * cos _angle_i + _center_x,
					_radius * sin _angle_i + _center_y,
					0  // To keep points on the ground/surface
				],
				true
			]
		);
	};
};

_circle_objects