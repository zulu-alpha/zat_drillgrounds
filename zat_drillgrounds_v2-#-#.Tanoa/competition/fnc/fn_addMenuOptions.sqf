/*

    Author: Phoenix of Zulu-Alpha

    Description: Add menu options to the controllers.

    Params:
        0: OBJECT - Root game logic for the range.
        1: OBJECT - Object to add gamelogic to

    Returns: None

*/

if !(hasInterface) exitWith {};

params ["_logicRoot", "_controlObject"];

_controlObject setVariable ["competition_logicRoot", _logicRoot, false];

_controlObject addAction [
    "Start round",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
        private _logicRoot = _target getVariable ["competition_logicRoot", objNull];
        [_logicRoot] remoteExec ["competition_fnc_doRound", 0, false];
    },
    nil,
    1.5, 
    true,
    true,
    "",
    "!((_target getVariable 'competition_logicRoot') getVariable ['competition_isActive', false]) and (count ((_target getVariable 'competition_logicRoot') getVariable ['competition_participants', []]) > 0)"
];

_controlObject addAction [
    "Abort round",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
        private _logicRoot = _target getVariable ["competition_logicRoot", objNull];
        _logicRoot setVariable ["competition_isActive", false, true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "(_target getVariable 'competition_logicRoot') getVariable ['competition_isActive', false]"
];

_controlObject addAction [
    "Become participant",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
        private _logicRoot = _target getVariable ["competition_logicRoot", objNull];

		private _participants = _logicRoot getVariable ["competition_participants", []];
		_participants pushBackUnique _caller;
        _logicRoot setVariable ["competition_participants", _participants, true];
        _caller setVariable ["competition_logicRoot", _logicRoot, true];

        if !(isDamageAllowed _caller) then {
            _caller setVariable ["competition_startedInvulnereble", true];
        } else {
            _caller allowDamage false;
        };

        [_caller] remoteExec ["competition_fnc_addHitEH", 0, false];

        _participant_names = [];
        {_participant_names pushBackUnique (name _x)} forEach _participants;
        hint format ["You are now one of %1 participants. All participants: %2", count _participants, _participant_names];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(_this in ((_target getVariable 'competition_logicRoot') getVariable ['competition_participants', []])) and !(captive _this) and !((_target getVariable 'competition_logicRoot') getVariable ['competition_isActive', false])"
];

_controlObject addAction [
    "Cease being a participant",
    {
		params ["_target", "_caller", "_actionId", "_arguments"];
        private _logicRoot = _target getVariable ["competition_logicRoot", objNull];

		private _participants = _logicRoot getVariable ["competition_participants", []];
        _logicRoot setVariable ["competition_participants", _participants - [_caller], true];
        _caller setVariable ["competition_logicRoot", nil, true];

        if !(_caller getVariable ["competition_startedInvulnereble", false]) then {
            _caller allowDamage true;
        };

        [_caller] remoteExec ["competition_fnc_removeHitEH", 0, false];

        hint "You are no longer a participant.";
    },
    nil,
    1.5,
    true,
    true,
    "",
    "_this in ((_target getVariable 'competition_logicRoot') getVariable ['competition_participants', []])"
];

_controlObject addAction [
    ("<t color=""#013ADF"">" + ("Make yourself captive") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller setCaptive true;
        hint "You are now captive. Undo this here when done.";
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(_this in ((_target getVariable 'competition_logicRoot') getVariable ['competition_participants', []])) and !(captive _this)"
];

_controlObject addAction [
    ("<t color=""#013ADF"">" + ("Stop being captive") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _caller setCaptive false;
        hint "You are no longer captive.";
    },
    nil,
    1.5,
    true,
    true,
    "",
    "captive _this"
];

_controlObject addAction [
    ("<t color=""#013ADF"">" + ("Enable announcements") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        private _logicRoot = _target getVariable ["competition_logicRoot", objNull];
        _logicRoot setVariable ["competition_doAnnouncements", true, true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!((_target getVariable 'competition_logicRoot') getVariable ['competition_doAnnouncements', true])"
];

_controlObject addAction [
    ("<t color=""#013ADF"">" + ("Disable announcements") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        private _logicRoot = _target getVariable ["competition_logicRoot", objNull];
        _logicRoot setVariable ["competition_doAnnouncements", false, true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "(_target getVariable 'competition_logicRoot') getVariable ['competition_doAnnouncements', true]"
];
