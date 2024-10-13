params ["_target", "_caller", "_actionId", "_arguments"];

_target removeAction _actionId;

hint "Select the first of four digits of your jump altitude.";

_action_trash = [];
_actions = [
	["0", 0],
	["1", 1000],
	["2", 2000],
	["3", 3000],
	["4", 4000],
	["5", 5000],
	["6", 6000],
	["7", 7000],
	["8", 8000],
	["9", 9000]
];

{
	_x params ["_text", "_altitude_add"];
	private _action = _target addAction [
		("<t color=""#fadfbe"">" + (_text) + "</t>"),
		"jump\2_alt_b.sqf",
		[_action_trash, _altitude_add]
	];
	_action_trash pushBack _action;
} forEach _actions;

_action = _target addAction [
	("<t color=""#FF0000"">" + ("Cancel") + "</t>"),
	"jump\cancel.sqf",
	[_action_trash]
];
_action_trash pushBack _action;
