/*

    Author: Phoenix of Zulu-Alpha

    Description: Returns count of all units in array of groups

    Params:
        0: ARRAY - Array of groups

    Returns: Int

*/

params ["_groups"];

private _total = 0;

{
    _total = _total + (count (units _x))
} count _groups;

_total