/*

    Author: Phoenix of Zulu-Alpha

    Description: Remove the eventhandler that made hinting and scoring work.
	Due to the way `HitPart` works, the EH had to be added everywhere, so it must be 
	removed everywhere.

    Params:
        0: OBJECT - Object to add the eventHandler to

    Returns: None

*/

params ["_participant"];

private _ehID = _participant getVariable ["competition_HitEhId", -1];

if !(_ehID == -1) then {
	_participant removeEventHandler ["HitPart", _ehID];
	_participant setVariable ["competition_HitEhId", nil, false];
};
