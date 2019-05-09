params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash",	"_strength", "_direction"];

{
	_target removeAction _x;
} foreach _action_trash;

[_strength, _direction] remoteExec ["wind_fnc_setWind", 2];

hint format ["
	Wind set!
	\nWind strength: %1m/s
	\nWind bearing so far: %2deg", 
	_strength, _direction
];

_target addAction [
	("<t color=""#fadfbe"">" + ("Set wind") + "</t>"),
	"wind\1_strength.sqf"
];
