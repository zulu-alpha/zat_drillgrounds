params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash", "_altitude", "_velocity"];

{
	_target removeAction _x;
} foreach _action_trash;

hint format ["
	Altitude: %1m
	\nVelocity: %2m/s
	\n
	\nSelect the first digit of your jump heading.", 
	_altitude, _velocity
];

_action_trash = [];
_actions = [
	["0", 0],
	["1", 100],
	["2", 200],
	["3", 300]
];

{
	_x params ["_text", "_direction_add"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"jump\8_dir_b.sqf",
		[_action_trash, _altitude,  _velocity, _direction_add]
	];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"jump\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
