/*

    Author: Phoenix of Zulu-Alpha

    Description: Adds addaction options to the control object for the system.

    Params:
        0: OBJECT - Control object 

    Returns: None

*/

if !(hasInterface) exitWith {};

params ["_control_object"];

_control_object addAction [
    "Become participant",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _participants = _target getVariable ["participants", []];
		_participants pushBackUnique _caller;
        _target setVariable ["participants", _participants, true];
		[_target] call threeddrill_fnc_cursorTargetLoop;
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(_this in (_target getVariable ['participants', []]))"
];

_control_object addAction [
    "Cease being a participant",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _participants = _target getVariable ["participants", []];
        _target setVariable ["participants", _participants - [_caller], true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "_this in (_target getVariable ['participants', []])"
];

_control_object addAction [
    "List participants",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _participants = _target getVariable ["participants", []];
        hint (str _participants);
    }
];

_control_object addAction [
    "Become observer",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _observers = _target getVariable ["observers", []];
		_observers pushBackUnique _caller;
        _target setVariable ["observers", _observers, true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(_this in (_target getVariable ['observers', []]))"
];

_control_object addAction [
    "Cease being a observer",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _observers = _target getVariable ["observers", []];
        _target setVariable ["observers", _observers - [_caller], true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "_this in (_target getVariable ['observers', []])"
];

_control_object addAction [
    "New round",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
        _target setVariable ["roundInProgress", true, true];
        [_target] remoteExec ["threeddrill_fnc_newRound", 0, false];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(_target getVariable ['roundInProgress', false])"
];

_control_object addAction [
    "Cancel round",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
        _target setVariable ["roundInProgress", false, true];
        hint "Round cancelled!";
    },
    nil,
    1.5,
    true,
    true,
    "",
    "(_target getVariable ['roundInProgress', false])"
];