params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash", "_altitude"];

{
	_target removeAction _x;
} foreach _action_trash;

hint format ["
	Altitude: %1m
	\n
	\nSelect the first of two digits for horizontal velocity.", 
	_altitude
];

_action_trash = [];
_actions = [
	["0", 0],
	["1", 10],
	["2", 20],
	["3", 30],
	["4", 40],
	["5", 50],
	["6", 60],
	["7", 70],
	["8", 80],
	["9", 90]
];

{
	_x params ["_text", "_velocity_add"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"jump\6_vel_b.sqf",
		[_action_trash, _altitude,  _velocity_add]
	];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"jump\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
