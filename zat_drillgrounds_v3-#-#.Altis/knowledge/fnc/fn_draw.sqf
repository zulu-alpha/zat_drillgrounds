/*

    Author: Phoenix of Zulu-Alpha

    Description: Draws all draw jobs in knowledge_drawJobs.
				 Format of knowledge_drawJobs are two nested arrays, the first one is for
				 the target lines and text and the other one is an array of groups for the
				 near eye lines.
    
	Params: None

    Returns: None

*/
private _knowledge_drawJobs = missionNamespace getVariable [
	"knowledge_drawJobs",
	[[], []]
];

{
	
	_x params [
		"_leader",
		"_knows_about_level",
		"_known_by_leader",
		"_last_seen",
		"_last_endangered",
		"_target_side",
		"_target_position",
		"_target"
	];

	private _color_state = switch (behaviour _leader) do {
		case "CARELESS": {[0.8, 0.8, 0.8, 1]};
		case "SAFE": {[1, 1, 1, 1]};
		case "AWARE": {[1, 1, 0, 1]};
		case "COMBAT": {[1, 0, 0, 1]};
		case "STEALTH": {[1, 0.5, 0, 1]};
		default {[1, 1, 1, 1]}
	};

	private _eyePos = ASLToAGL (eyePos _leader);
	private _targetPos = ASLToAGL _target_position;

	drawLine3D [
		_eyePos,
		_targetPos,
		_color_state
	];

	if (_target == player) then {
		drawIcon3D [
			"",
			_color_state,
			[_eyePos select 0, _eyePos select 1, (_eyePos select 2) + 1],
			0,
			0,
			0,
			format [
				"%2%1, Seen: %3s, Danger: %4s, Dist: %5m",
				"%",
				round (linearConversion [0, 4, _knows_about_level, 0, 100, false]),
				_last_seen,
				_last_endangered,
				round (_eyePos distance _targetPos)
			],
			0,
			// Base size / distance to player camera, capped to 70 meters for max size of text
			// * zoom level and max all of this to 0.013 for minimum size of text and min that
			// to 0.03 for a maximum size
			((2 / ((_eyePos distance (positionCameraToWorld [0,0,0])) max 0.01) * 
				(call knowledge_fnc_getZoom)) max 0.013) min 0.03,
			"LucidaConsoleB",
			"center",
			true
		];
	};

} forEach (_knowledge_drawJobs select 0);

{
	private _group = _x;
	{

		private _start_point = ASLToAGL eyePos _x;
		private _end_point = _start_point vectorAdd (
			(eyeDirection _x) vectorMultiply 100
		);
		drawLine3D [
			_start_point,
			_end_point,
			[0,0,1,1]
		];
	} forEach (units _group);
} forEach (_knowledge_drawJobs select 1);
