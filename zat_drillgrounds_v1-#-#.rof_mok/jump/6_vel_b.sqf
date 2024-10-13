params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash", "_altitude", "_velocity"];

{
	_target removeAction _x;
} foreach _action_trash;

hint format ["
	Altitude: %1m
	\nVelocity so far: %2m/s
	\n
	\nSelect the second of two digits for horizontal velocity.", 
	_altitude, _velocity
];

_action_trash = [];
_actions = [
	["0", 0],
	["1", 1],
	["2", 2],
	["3", 3],
	["4", 4],
	["5", 5],
	["6", 6],
	["7", 7],
	["8", 8],
	["9", 9]
];

{
	_x params ["_text", "_velocity_add"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"jump\7_dir_a.sqf",
		[_action_trash, _altitude,  _velocity + _velocity_add]
	];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"jump\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
