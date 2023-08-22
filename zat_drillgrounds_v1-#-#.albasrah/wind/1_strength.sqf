params ["_target", "_caller", "_actionId", "_arguments"];

_target removeAction _actionId;

hint "Select your wind strength";

_action_trash = [];
_actions = [
	["0 m/s", 0],
	["1 m/s", 1],
	["2 m/s", 2],
	["3 m/s", 3],
	["4 m/s", 4],
	["5 m/s", 5],
	["6 m/s", 6],
	["7 m/s", 7],
	["8 m/s", 8],
	["9 m/s", 9],
	["10 m/s", 10],
	["11 m/s", 11],
	["12 m/s", 12],
	["13 m/s", 13],
	["14 m/s", 14],
	["15 m/s", 15],
	["16 m/s", 16],
	["17 m/s", 17],
	["18 m/s", 18],
	["19 m/s", 19],
	["20 m/s", 20]
];

{
	_x params ["_text", "_strength"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"wind\2_dir_a.sqf",
		[_action_trash, _strength]
	];
	_action_trash set [count _action_trash, _action];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"wind\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
