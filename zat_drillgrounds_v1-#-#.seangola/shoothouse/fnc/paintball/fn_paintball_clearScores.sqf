/*

    Author: Phoenix of Zulu-Alpha

    Description: Deletes all paintbal mode participant's scores.

    Params:
        0: OBJECT - Course object

    Returns: None

*/

params ["_course"];

private _participants = _course getVariable ["shoothouse_paintballers", []];

{
	_x setVariable ["shoothouse_paintball_hits", 0, true];
} forEach _participants;

hint "Scores cleared!";
