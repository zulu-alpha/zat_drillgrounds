params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash"];

{
	_target removeAction _x;
} foreach _action_trash;

hint "Wind change cancelled.";

_target addAction [
	("<t color=""#fadfbe"">" + ("Set wind") + "</t>"),
	"wind\1_strength.sqf"
];
