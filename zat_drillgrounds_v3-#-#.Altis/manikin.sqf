/*
	Author: Phoenix

	Description: Adds addaction menu options for spawning or deleting a manikin on the given object (such as a mat)

	Params:
	  0: OBJECT - The object that stores information and has the addaction options.
	  1: OBJECT - The object the manikin spawns on top of. 
	  2: STRING - The config name of the man to spawn (decides side).

	Usage: nul = [this, this, "O_G_Soldier_unarmed_F"] execVM "manikin.sqf";

	Reference:
		damageTypes: bullet, grenade, explosive, shell, vehiclecrash, collision,
		backblast, stab, punch, falling, ropeburn, drowning, unknown

		Body parts: Head, Body, LeftArm, RightArm, LeftLeg, RightLeg

*/

if !(hasInterface) exitWith {};
waitUntil {(time > 1) and {!(isNull player)}};

params ["_controller", "_mat", "_model"];


private _manikin_create = {

	/*
		Description: For spawning a dummy AI suitable for medical training. Add to object to spawn manikin on
		Usage: _mat addaction ["Spawn manikin", _manikin_create, [_mat, _model], 1.5, true, true, "", "isNull (_target getVariable ['med_dummy', ObjNull])"];
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_mat", "_model"];
	private _pos = getPosATL _mat;

	if !(isNull (_target getVariable ["med_dummy", ObjNull])) exitWith {
		hint "Manikin already spawned!";
	};

	private _manikin_group = createGroup east;
	private _manikin = _manikin_group createUnit [_model, _pos, [], 0, "NONE"];
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

	_target setVariable ['med_dummy', _manikin, true];

};

private _manikin_delete = {

	/*
		Description: Delete manakin spawned with med_dummy.sqf
		Usage: _mat addaction ["Delete manikin", _manikin_delete, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull]))"];
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	private _manikin = _target getVariable ["med_dummy", ObjNull];

	if (isNull _manikin) exitWith {
		hint "No manikin spawned!"
	};

	deleteVehicle _manikin;

};

private _manikin_add_wound = {

	/*
		Description: Add random wound to manikin
		Usage: _mat addaction ["Add wound", _manikin_add_wound, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull])) and {local (_target getVariable ['med_dummy', ObjNull])}"];
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	private _manikin = _target getVariable ["med_dummy", ObjNull];

	[
		_manikin, 
		(0.5 + random 0.5),
		selectRandom ["head", "body", "hand_l", "hand_l", "hand_r", "leg_l", "leg_r"],
		selectRandom ["bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast", "stab", "punch", "falling"]
	] call ace_medical_fnc_addDamageToUnit;

};


_controller addaction ["Spawn manikin", _manikin_create, [_mat, _model], 1.5, true, true, "", "isNull (_target getVariable ['med_dummy', ObjNull])"];
_controller addaction ["Delete manikin", _manikin_delete, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull]))"];
_controller addaction ["Add wound", _manikin_add_wound, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull])) and {local (_target getVariable ['med_dummy', ObjNull])}"];
