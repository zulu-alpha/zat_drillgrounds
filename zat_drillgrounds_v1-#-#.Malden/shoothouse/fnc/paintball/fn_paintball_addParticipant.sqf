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
	_participants set [count _participants, _participant];
	_course setVariable ["shoothouse_paintballers", _participants, true];

    private _eh_id = _participant addEventHandler ["HitPart", {
	    _this select 0 params ["_target", "_shooter", "_bullet", "_position", "_velocity", "_selection", "_ammo", "_direction", "_radius", "_surface", "_direct"];
        hint format ["You where hit in the %1 by a %2 round!", _selection, _ammo];
        private _target_hits = _target getVariable ["shoothouse_paintball_hits", 0];
        _target_hits = _target_hits + 1;
        _target setVariable ["shoothouse_paintball_hits", _target_hits, true];
    }];
    _participant setVariable ["shoothouse_paintball_eh_id", _eh_id, true];

    hint "You are now a paintball mode participant!";
} else {
    hint "You are already a paintball mode participant!";
};

_participant allowDamage false;