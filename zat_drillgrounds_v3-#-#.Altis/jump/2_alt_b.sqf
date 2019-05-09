params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash", "_altitude"];

{
	_target removeAction _x;
} foreach _action_trash;

hint format ["
	Altitude so far: %1m
	\n
	\nSelect the second of four digits of your jump altitude.", 
	_altitude
];

_action_trash = [];
_actions = [
	["0", 0],
	["1", 100],
	["2", 200],
	["3", 300],
	["4", 400],
	["5", 500],
	["6", 600],
	["7", 700],
	["8", 800],
	["9", 900]
];

{
	_x params ["_text", "_altitude_add"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"jump\3_alt_c.sqf",
		[_action_trash, _altitude + _altitude_add]
	];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"jump\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
