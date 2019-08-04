/*

    Author: Phoenix of Zulu-Alpha

    Description: Remove the invulnerability and monitoring of the paintball mode participant.

    Params:
        0: OBJECT - Course object
        1: OBJECT - Object to initialize paintball mode for

    Returns: None

*/

params ["_course", "_participant"];

if !(local _participant) exitWith {};

private _participants = _course getVariable ["shoothouse_paintballers", []];

if (_participant in _participants) then {
	_participants = _participants - [_participant];
	_course setVariable ["shoothouse_paintballers", _participants, true];

	private _eh_id = _participant getVariable ["shoothouse_paintball_eh_id"];
	_participant removeEventHandler ["HitPart", _eh_id];
	_participant setVariable ["shoothouse_paintball_eh_id", nil, true];

    hint "You are no longer a paintball mode participant!";
} else {
    hint "You where not a paintball mode participant!";
};

_participant allowDamage true;