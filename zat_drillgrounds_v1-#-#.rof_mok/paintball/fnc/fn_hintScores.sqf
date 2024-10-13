/*

    Author: Phoenix of Zulu-Alpha

    Description: Hint all paintbal mode participant's scores.

    Params:
        0: OBJECT - Course object

    Returns: None

*/

params ["_course"];

private _participants = _course getVariable ["paintballers", []];

private _score_string = "<t align='center'>Paintball mode hits:";
{
	private _hits = _x getVariable ["paintball_hits", 0];
	private _str = format ["<br/>%1: <t color='#ffff00'>%2</t>", name _x, _hits];
	_score_string = _score_string + _str;
} forEach _participants;

hint parseText _score_string;
