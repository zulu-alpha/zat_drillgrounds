/*
	Author: Phoenix

	Description: For creating a mass casualty incident with multiple casualties and
			     providing options to manage them.

	Params:
	  0: OBJECT - The controller object that the other objects are synced to.

	Usage: Synchronize objects to spawn the different manikins on top of to the object 
		   that this script refers to, as well as one or more cones to add the addaction 
		   options for, then add the variable `multi_manikin_casualty' to the name spaces
		   of each of the synchronized mats, where the contents of those variables follows
		   the format:
			0: ARRAY - Any number of nested arrays specifying the wounds, of format:
				0: NUMBER - Damage of wound
				1: STRING - Body part
				2: STRING - Wound type

		So for example, in the init of the control object, put: 
			nul = [this] execVM "multi_manikin.sqf";

		Then synchronize it to several mats, and in each of those mats, put in their init:
			this setVariable [
				"multi_manikin_casualty", 
				[
					[0.5, "LeftArm", "bullet"],
					[0.3, "Body", "shell"]
				], 
				true
			];
		
		Then synchronize to a cone. Nothing needs to be in the init of that cone.

		Valid mat objects are: ShootingMat_01_Olive_F, ShootingMat_01_Khaki_F,
		                       ShootingMat_01_OPFOR_F
		Valid cone objects are: RoadCone_L_F, Land_RoadCone_01_F, RoadCone_F

	Reference:
		Body parts: Head, Body, LeftArm, RightArm, ""LeftLeg"", RightLeg

		damageTypes: bullet, grenade, explosive, shell, vehiclecrash, collision,
		backblast, stab, punch, falling, ropeburn, drowning, unknown

*/

if !(hasInterface) exitWith {};
waitUntil {(time > 1) and {!(isNull player)}};

params ["_controller"];

private _man_type = "O_G_Soldier_unarmed_F";
private _man_side = east;
private _mat_types = [
	"ShootingMat_01_Olive_F",
	"ShootingMat_01_Khaki_F",
	"ShootingMat_01_OPFOR_F"
];
private _cone_types = [
	"RoadCone_L_F",
	"Land_RoadCone_01_F",
	"RoadCone_F"
];

private _mats = [];
private _cones = [];

{
	if (typeOf _x in _mat_types) then {
		_mats pushBackUnique _x;
	};
	if (typeOf _x in _cone_types) then {
		_cones pushBackUnique _x;
	};
} forEach (synchronizedObjects _controller);


multi_manikin_fnc_create = {
	/*
		Description: For spawning a dummy AI suitable for medical training and returning
		that manikin.
	*/

	params ["_mat", "_man_type", "_man_side"];
	private _pos = getPosATL _mat;

	if !(isNull (_mat getVariable ["med_dummy", ObjNull])) exitWith {
		hint (format ["Manikin already spawned for mat %1!", _mat]);
	};

	private _manikin_group = createGroup _man_side;
	_manikin_group deleteGroupWhenEmpty true;
	private _manikin = _manikin_group createUnit [_man_type, _pos, [], 0, "NONE"];
	removeAllWeapons _manikin;
	removeAllItems _manikin;
	removeAllAssignedItems _manikin;
	removeUniform _manikin;
	removeVest _manikin;
	removeBackpack _manikin;
	removeHeadgear _manikin;
	removeGoggles _manikin;
	_manikin setPosATL _pos;
	_manikin setDir (getDir _mat);

	{
		_manikin disableAI _x;
	} forEach [
		"TARGET", "AUTOTARGET", "MOVE", "TEAMSWITCH", "FSM", "AIMINGERROR", "SUPPRESSION",
		"CHECKVISIBLE", "COVER", "AUTOCOMBAT", "PATH"
	];

	_mat setVariable ['med_dummy', _manikin, true];

	_manikin
};


private _manikin_create_and_wound_all = {
	/*
		Description: For spawning manikins for each mat and add their specified wounds.
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_mats", "_man_type", "_man_side"];

	{
		private _mat = _x;
		private _wounds = _mat getVariable ["multi_manikin_casualty", []];
		private _manikin = [_mat, _man_type, _man_side] call multi_manikin_fnc_create;
		{
			_x params ["_damage", "_body_part", "_wound_type"];
			[
				_manikin,
				_damage,
				_body_part,
				_wound_type,
				_caller
			] call ace_medical_fnc_addDamageToUnit;
		} forEach _wounds;
		[_manikin, true] call ace_medical_fnc_setUnconscious;
	} forEach _mats;

};


private _manikin_delete_all = {

	/*
		Description: Delete all manikins tied to the given mats.
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_mats"];

	{
		private _manikin = _x getVariable ["med_dummy", ObjNull];
		if (isNull _manikin) then {
			hint (format ["No manikin spawned for mat %1!", _x]);
		} else {
			deleteVehicle _manikin;
		};
	} forEach _mats;

};

{
	_x addaction ["Spawn manikins", _manikin_create_and_wound_all, [_mats, _man_type, _man_side]];
	_x addaction ["Delete manikins", _manikin_delete_all, [_mats]];
} forEach _cones;
