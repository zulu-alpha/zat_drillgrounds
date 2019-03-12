/*

    Author: Phoenix of Zulu-Alpha

    Description: Monitor participant for paintball mode and activate it for them (involves sending hit info and making it invulnerable).

    Params:
        0: OBJECT - Course object
        1: OBJECT - Object to initialize paintball mode for

    Returns: None

*/

params ["_course", "_participant"];

if !(local _participant) exitWith {};

private _participants = _course getVariable ["shoothouse_paintballers", []];

if !(_participant in _participants) then {
    [_course, _participant] remoteExec ["shootHouse_fnc_paintball_addEH", 0, false];
	_participants set [count _participants, _participant];
	_course setVariable ["shoothouse_paintballers", _participants, true];

    hint "You are now a paintball mode participant!";
} else {
    hint "You are already a paintball mode participant!";
};

_participant allowDamage false;