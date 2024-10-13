_pole = _this select 0;
_action_trash = (_this select 3) select 0;

{
	_pole removeAction _x;
} foreach _action_trash;

onMapSingleClick "";
hint "";

waitUntil {!(isNull _pole)};

_action_trash = [];

_action = _pole addAction [("<t color=""#fadfbe"">" + ("Spectate and listen in") + "</t>"),{[player, false, false] call zamf_fnc_startSpectate;}, [_action_trash], -11];
_action_trash set [count _action_trash, _action];
_action = _pole addAction [("<t color=""#fadfbe"">" + ("Spectate") + "</t>"),{[player, true, false] call zamf_fnc_startSpectate;}, [_action_trash], -11];
_action_trash set [count _action_trash, _action];
_action = player addAction[("<t color=""#fadfbe"">" + ("Freecam") + "</t>"),"training\training_freecam.sqf", [_action_trash], -13];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("Move Teleporter") + "</t>"),"training\training_teleport.sqf", [_action_trash], -14];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("Switch Side") + "</t>"),"training\training_side.sqf", [_pole], -15];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("Hide Yourself") + "</t>"),"training\training_hide.sqf", [_pole], -16];
_action_trash set [count _action_trash, _action];
