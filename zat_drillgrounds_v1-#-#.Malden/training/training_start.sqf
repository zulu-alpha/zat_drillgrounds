_pole = _this select 0;
_action_trash = (_this select 3) select 0;

{
	_pole removeAction _x;
} foreach _action_trash;

onMapSingleClick "";
hint "";

waitUntil {!(isNull _pole)};

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("Freecam") + "</t>"),"training\training_freecam.sqf", [_action_trash], -12];
_action_trash set [count _action_trash, _action];
_action = _pole addAction [("<t color=""#fadfbe"">" + ("Spectate") + "</t>"),{["Initialize", [player, [], true]] call BIS_fnc_EGSpectator}, [_action_trash], -13];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("Delete units") + "</t>"),"training\training_delete.sqf", [_action_trash], -14];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("Move Teleporter") + "</t>"),"training\training_teleport.sqf", [_action_trash], -15];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("Switch Side") + "</t>"),"training\training_side.sqf", [_pole], -16];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("Hide Yourself") + "</t>"),"training\training_hide.sqf", [_pole], -17];
_action_trash set [count _action_trash, _action];
