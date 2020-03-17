params ["_logicRoot", "_stage", "_stageNumber", "_participants"];

call compile "competition_scripts/mass_casualty/common.sqf";

private _mats = [];

{
	if (typeOf _x in multi_manikin_mat_types) then {
		_mats pushBackUnique _x;
	};
} forEach (synchronizedObjects _stage);

{
	private _manikin = _x getVariable ["med_dummy", ObjNull];
	if (isNull _manikin) then {
		hint (format ["No manikin spawned for mat %1!", _x]);
	} else {
		deleteVehicle _manikin;
	};
} forEach _mats;