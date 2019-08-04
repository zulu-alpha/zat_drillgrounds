/*
	Author: Phoenix
	Description: Adds addaction menu options for spawning or deleting a manikin on the given object (such as a mat)
	Usage: nul = [this, "O_G_Soldier_unarmed_F"] execVM "manikin.sqf";
*/

params ["_mat", "_model"];


private _manikin_create = {

	/*
		Description: For spawning a dummy AI suitable for medical training. Add to object to spawn manikin on
		Usage: _mat addaction ["Spawn manikin", _manikin_create, [_model], 1.5, true, true, "", "isNull (_target getVariable ['med_dummy', ObjNull])"];
	*/

	private _mat = _this select 0;
	private _pos = getPosATL _mat;
	private _model = (_this select 3) select 0;

	if !(isNull (_mat getVariable ["med_dummy", ObjNull])) exitWith {
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

	_manikin disableAI "TARGET";
	_manikin disableAI "AUTOTARGET";
	_manikin disableAI "MOVE";
	//_manikin disableAI "ANIM";  // Not sure if has negative effect
	_manikin disableAI "TEAMSWITCH";
	_manikin disableAI "FSM";
	_manikin disableAI "AIMINGERROR";
	_manikin disableAI "SUPPRESSION";
	_manikin disableAI "CHECKVISIBLE";
	_manikin disableAI "COVER";
	_manikin disableAI "AUTOCOMBAT";
	_manikin disableAI "PATH";

	_mat setVariable ['med_dummy', _manikin, true];

};

private _manikin_delete = {

	/*
		Description: Delete manakin spawned with med_dummy.sqf
		Usage: _mat addaction ["Delete manikin", _manikin_delete, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull]))"];
	*/

	private _mat = _this select 0;
	private _manikin = _mat getVariable ["med_dummy", ObjNull];

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

	private _mat = _this select 0;
	private _manikin = _mat getVariable ["med_dummy", ObjNull];

	[
		_manikin, 
		(0.2 + random 0.6),
		selectRandom ["head", "body", "hand_l", "hand_l", "hand_r", "leg_l", "leg_r"],
		selectRandom ["bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast", "stab", "punch", "falling", "unknown"]
	] call ace_medical_fnc_addDamageToUnit;

};

private _manikin_cardiac_arrest = {

	/*
		Description: Give the manikin a cardiac arrest
		Usage: _mat addaction ["Give cardiac arrest", _manikin_cardiac_arrest, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull])) and {local (_target getVariable ['med_dummy', ObjNull])}"];
	*/

	private _mat = _this select 0;
	private _manikin = _mat getVariable ["med_dummy", ObjNull];

	[_manikin] call ace_medical_fnc_setCardiacArrest

};


_mat addaction ["Spawn manikin", _manikin_create, [_model], 1.5, true, true, "", "isNull (_target getVariable ['med_dummy', ObjNull])"];
_mat addaction ["Delete manikin", _manikin_delete, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull]))"];
_mat addaction ["Add wound", _manikin_add_wound, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull])) and {local (_target getVariable ['med_dummy', ObjNull])}"];
_mat addaction ["Give cardiac arrest", _manikin_cardiac_arrest, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull])) and {local (_target getVariable ['med_dummy', ObjNull])}"];
