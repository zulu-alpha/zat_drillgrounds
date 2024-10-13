params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash", "_strength"];

{
	_target removeAction _x;
} foreach _action_trash;

hint format ["
	Wind strength: %1m/s
	\n
	\nSelect the first digit of your wind bearing.", 
	_strength
];

_action_trash = [];
_actions = [
	["0", 0],
	["1", 100],
	["2", 200],
	["3", 300]
];

{
	_x params ["_text", "_direction"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"wind\3_dir_b.sqf",
		[_action_trash, _strength, _direction]
	];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"wind\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
