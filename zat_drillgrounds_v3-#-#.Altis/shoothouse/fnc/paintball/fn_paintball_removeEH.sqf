/*

    Author: Phoenix of Zulu-Alpha

    Description: Remove the eventhandler that made hinting and scoring work.
	Due to the way `HitPart` works, the EH had to be added everywhere, so it must be 
	removed everywhere.

    Params:
        0: OBJECT - Object to initialize paintball mode for

    Returns: None

*/

params ["_participant"];

private _eh_id = _participant getVariable ["shoothouse_paintball_eh_id", -1];

if !(_eh_id == -1) then {
	_participant removeEventHandler ["HitPart", _eh_id];
	_participant setVariable ["shoothouse_paintball_eh_id", nil, false];
};
