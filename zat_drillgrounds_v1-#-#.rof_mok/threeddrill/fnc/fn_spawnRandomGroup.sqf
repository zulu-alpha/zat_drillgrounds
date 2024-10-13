/*

    Author: Phoenix of Zulu-Alpha

    Description: Spawns a random number and set of units at a random position relative to
                 the given reference object.

    Params:
        0: OBJECT - Reference object.

    Returns: Group

*/

params ["_refObject"];

private _group = createGroup east;
_group setBehaviour "SAFE";

_numToSpawn = 1 + (round (random (threeddrill_max_spawn - 1)));
private _pos = [_refObject] call threeddrill_fnc_randomPosition;
private _dir = [_pos, getPosATL _refObject] call BIS_fnc_dirTo;

for "_i" from 1 to _numToSpawn do {
    private _target = _group createUnit [
        selectRandom threeddrill_enemy_types,
        _pos,
        [],
        0,
        "NONE"
    ];
    _target setFormDir _dir;
    _target setDir _dir;
    _target setVariable ["acex_headless_blacklist", true, true];
};
_group setCombatMode "BLUE";
_group deleteGroupWhenEmpty true;

_group