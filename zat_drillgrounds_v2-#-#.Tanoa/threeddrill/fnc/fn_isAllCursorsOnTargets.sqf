/*

    Author: Phoenix of Zulu-Alpha

    Description: Checks if all the given player's cursors are on at least one of the given
                 group's units.

    Params:
        0: ARRAY - Array of players to check for.
        1: GROUP - Group that must have all their cursors on.

    Returns: BOOLEAN

*/

params ["_players", "_group"];

private _cursorObjects = [];
{
    private _isUnconscious = _x getVariable ["ace_isunconscious", false];
    if (!(isNull _x) and {alive _x} and {canFire _x} and {!(_isUnconscious)}) then {
        _cursorObjects pushBackUnique (_x getVariable ["cursorTarget", objNull]) 
    };
} forEach _players;

private _badCursorTargets = [];

{
    if !(_x in (units _group)) exitWith {
        _badCursorTargets pushBack _x;
    };
} forEach _cursorObjects;

(count _badCursorTargets) == 0;