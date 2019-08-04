_pole = _this select 0;
_action_trash = (_this select 3) select 0;

{
	_pole removeAction _x;
}foreach _action_trash;

hint "Click on a unit on the map to delete it.";

onMapSingleClick "

_units = nearestObjects [_pos, [""Man"",""AllVehicles""], 10];

_unit = _units select 0;

if ((count _units > 0) && {!(isPlayer _unit)}) then {
	deletevehicle _unit;
	hint str(_unit);
};
";

_action = _pole addAction[("<t color=""#ff8a00"">" + ("Back") + "</t>"),"training\training_start.sqf", [_action_trash], 10];
_action_trash set [count _action_trash, _action];