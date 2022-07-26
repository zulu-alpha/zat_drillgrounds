/*

    Author: Phoenix of Zulu-Alpha

    Description: Remove the invulnerability and monitoring of the paintball mode participant.

    Params:
        0: OBJECT - Course object
        1: OBJECT - Object to initialize paintball mode for
        2: BOOL - True to let the user know when they are added

    Returns: None

*/

params ["_course", "_participant", "_to_hint"];

if !(local _participant) exitWith {};

private _participants = _course getVariable ["paintballers", []];

if (_participant in _participants) then {
	_participants = _participants - [_participant];
	_course setVariable ["paintballers", _participants, true];
    [_participant] remoteExec ["paintball_fnc_removeEH", 0, false];
    if (_to_hint) then {
        hint "You are no longer a paintball mode participant!";
    };
} else {
    if (_to_hint) then {
        hint "You where not a paintball mode participant!";
    };
};

if !(_participant getVariable ["paintball_was_already_invulnerable", false]) then {
    _participant allowDamage true;
};
