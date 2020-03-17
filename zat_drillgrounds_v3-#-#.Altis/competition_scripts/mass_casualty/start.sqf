params ["_logicRoot", "_stage", "_stageNumber", "_participants"];

call compile "competition_scripts/common.sqf";

private _mats = [];

{
	if (typeOf _x in multi_manikin_mat_types) then {
		_mats pushBackUnique _x;
	};
} forEach (synchronizedObjects _stage);

multi_manikin_fnc_create = {
	/*
		Description: For spawning a dummy AI suitable for medical training and returning
		that manikin.
	*/

	params ["_mat", "multi_manikin_man_type", "multi_manikin_man_side"];
	private _pos = getPosATL _mat;

	if !(isNull (_mat getVariable ["med_dummy", ObjNull])) exitWith {
		hint (format ["Manikin already spawned for mat %1!", _mat]);
	};

	private _manikin_group = createGroup multi_manikin_man_side;
	private _manikin = _manikin_group createUnit [multi_manikin_man_type, _pos, [], 0, "NONE"];
	_manikin_group deleteGroupWhenEmpty true;
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

{
	private _mat = _x;
	private _wounds = _mat getVariable ["multi_manikin_casualty", []];
	private _manikin = [_mat, multi_manikin_man_type, multi_manikin_man_side] call multi_manikin_fnc_create;
	{
		_x params ["_damage", "_body_part", "_wound_type"];
		[
			_manikin,
			_damage,
			_body_part,
			_wound_type
		] call ace_medical_fnc_addDamageToUnit;
	} forEach _wounds;
	[_manikin, true] call ace_medical_fnc_setUnconscious;
} forEach _mats;