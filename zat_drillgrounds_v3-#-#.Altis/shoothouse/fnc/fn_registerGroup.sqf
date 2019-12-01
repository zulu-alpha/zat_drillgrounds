/*

    Author: Phoenix of Zulu-Alpha

    Description: Registers group as part of given course object.

    Params:
        0: OBJECT - Course object
        1: OBJECT - Target object

    Returns: None

*/

params ["_course", "_target_group"];

private _active_groups = _course getVariable ["shoothouse_groups_active", []];
_active_groups pushBackUnique _target_group;
_course setVariable ["shoothouse_groups_active", _active_groups, true];

// Register all units in the groups for future junk deletion
private _junk = _course getVariable ["shoothouse_junk", []];
_junk = _junk + (units _target_group);
_course setVariable ["shoothouse_junk", _junk];
