params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash", "_altitude", "_velocity", "_direction"];

{
	_target removeAction _x;
} foreach _action_trash;

hint format ["
	Altitude: %1m
	\nVelocity: %2m/s
	\nJump heading so far: %3deg
	\n
	\nSelect the third digit of your jump heading.", 
	_altitude, _velocity, _direction
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
	_x params ["_text", "_direction_add"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"jump\10_pos.sqf",
		[_action_trash, _altitude,  _velocity, _direction + _direction_add]
	];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"jump\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
