params ["_cone"];

_cone addAction ["Spectate and listen in", {[player, false, false] call zamf_fnc_startSpectate;}];
_cone addAction ["Spectate", {[player, true, false] call zamf_fnc_startSpectate;}];
