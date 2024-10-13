/*
*	Author: Phoenix
* 	Description: Put arrow markers into a formation for demonstration purposes.
* 	Usage:
*		Make invisible objects (like your own arrows) and name them and place them in a grid as described below:
* 			formations_00 formations_10 formations_20 formations_30 formations_40 formations_50 formations_60
*			formations_01 formations_11 formations_21 formations_31 formations_41 formations_51 formations_61
*			formations_02 formations_12 formations_22 formations_32 formations_42 formations_52 formations_62
*			formations_03 formations_13 formations_23 formations_33 formations_43 formations_53 formations_63
*		
*		Then make a wall and put invisible objects like above, except with names and ordered like so:*	
*			formations_wall_0 formations_wall_1 formations_wall_2 formations_wall_3

*		Then name the billboard: formations_billboard
*
*		Then call this function with and addaction call with the argument being either: 
*			"column", "staggered_column", "line_right", "line_left", "line_facing_left", "line_facing_right", 
*			"wedge_left", "wedge_right", "go_firm" or "wall_formation".
*/

params ["_target", "_caller", "_id", "_formation"];

private _ftl = "Sign_Arrow_Direction_F";
private _r = "Sign_Arrow_Direction_Pink_F";
private _ar = "Sign_Arrow_Direction_Blue_F";
private _g = "Sign_Arrow_Direction_Cyan_F";
private _any = "Sign_Arrow_Direction_Yellow_F";

if (isNil "formations_arrows") then {
	formations_arrows = [];
	publicVariable "formations_arrows";
};

private _create = {
	params ["_type", "_reference", "_dir"];
	// _dir is degrees added to reference object's direction.
	_arrow = createVehicle [_type, [0,0,0], [], 0, "NONE"];
	formations_arrows set [count formations_arrows, _arrow];
	_arrow setDir (_dir + (getDir _reference));
	_arrow setPos (getPos _reference);
};

{deleteVehicle _x} forEach formations_arrows;

switch (_formation) do {
	case "column": {
		[_ftl, formations_30, 0] call _create;
		[_r, formations_31, 0] call _create;
		[_ar, formations_32, 0] call _create;
		[_g, formations_33, 0] call _create;
		formations_billboard setObjectTexture [0, "formations\img\col.JPG"];
	};
	case "staggered_column": {
		[_ftl, formations_30, 0] call _create;
		[_r, formations_51, 0] call _create;
		[_ar, formations_32, 0] call _create;
		[_g, formations_53, 0] call _create;
		formations_billboard setObjectTexture [0, "formations\img\stagcol.JPG"];
	};
	case "line_right": {
		[_ftl, formations_30, 0] call _create;
		[_r, formations_40, 0] call _create;
		[_ar, formations_50, 0] call _create;
		[_g, formations_60, 0] call _create;
		formations_billboard setObjectTexture [0, "formations\img\liner.JPG"];
	};
	case "line_left": {
		[_ftl, formations_30, 0] call _create;
		[_r, formations_20, 0] call _create;
		[_ar, formations_10, 0] call _create;
		[_g, formations_00, 0] call _create;
		formations_billboard setObjectTexture [0, "formations\img\linel.JPG"];
	};
	case "line_facing_right": {
		[_ftl, formations_30, 90] call _create;
		[_r, formations_31, 90] call _create;
		[_ar, formations_32, 90] call _create;
		[_g, formations_33, 90] call _create;
		formations_billboard setObjectTexture [0, "formations\img\liner.JPG"];
	};
	case "line_facing_left": {
		[_ftl, formations_30, 270] call _create;
		[_r, formations_31, 270] call _create;
		[_ar, formations_32, 270] call _create;
		[_g, formations_33, 270] call _create;
		formations_billboard setObjectTexture [0, "formations\img\linel.JPG"];
	};
	case "wedge_left": {
		[_ftl, formations_30, 0] call _create;
		[_r, formations_21, 0] call _create;
		[_ar, formations_41, 0] call _create;
		[_g, formations_12, 0] call _create;
		formations_billboard setObjectTexture [0, "formations\img\wedgel.JPG"];
	};
	case "wedge_right": {
		[_ftl, formations_30, 0] call _create;
		[_r, formations_41, 0] call _create;
		[_ar, formations_21, 0] call _create;
		[_g, formations_52, 0] call _create;
		formations_billboard setObjectTexture [0, "formations\img\wedgel.JPG"];
	};
	case "go_firm": {
		[_any, formations_30, 0] call _create;
		[_any, formations_21, 270] call _create;
		[_any, formations_41, 90] call _create;
		[_any, formations_32, 180] call _create;
		formations_billboard setObjectTexture [0, "formations\img\firm.JPG"];
	};
	case "wall_formation": {
		[_any, formations_wall_0, 0] call _create;
		[_any, formations_wall_1, 0] call _create;
		[_any, formations_wall_2, 0] call _create;
		[_any, formations_wall_3, 0] call _create;
		formations_billboard setObjectTexture [0, "formations\img\stack.JPG"];
	};
};

publicVariable "formations_arrows";
