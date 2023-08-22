/*

    Author: Phoenix of Zulu-Alpha

    Description: Monitor participant for paintball mode and activate it for them (involves sending hit info and making it invulnerable).

    Params:
        0: OBJECT - Course object
        1: OBJECT - Object to initialize paintball mode for
        2: BOOL - True to let the user know when they are added

    Returns: None

*/

params ["_course", "_participant", "_to_hint"];

if !(local _participant) exitWith {};

private _participants = _course getVariable ["paintballers", []];

if !(_participant in _participants) then {
    [_course, _participant] remoteExec ["paintball_fnc_addEH", 0, false];
	_participants set [count _participants, _participant];
	_course setVariable ["paintballers", _participants, true];

    if (_to_hint) then {
        hint "You are now a paintball mode participant!";
    };
} else {
    if (_to_hint) then {
        hint "You are already a paintball mode participant!";
    };
};

if !(isDamageAllowed _participant) then {
    _participant setVariable ["paintball_was_already_invulnerable", true];
} else {
    _participant allowDamage false;
};
