/*

    Author: Phoenix of Zulu-Alpha

    Description: Process each unit inside the target unit's group and return the group array.

    Params:
        0: OBJECT - Object that represents the a group (soldier) of targets.

    Returns: ARRAY - Array of format [[<class name string>, <SIDE>, <position atl array>, <direction number>, <stance string>]]

*/

params ["_obj"];

private _obj_group = group _obj;
private _group_array = [];

// Remember the group to avoid processing it again or quit if already processed
// Also if processing a unit which was just deleted as another unit in it's group was 
// already processed.
if ((isNull _obj_group) or {_obj_group in shoothouse_var_processed_groups}) exitWith {};
shoothouse_var_processed_groups pushBack _obj_group;

// Iterate through each unit in target unit's group
{
    _group_array pushBack 
    [
        typeOf _x,
        side _x,
        getPosATL _x,
        getDir _x,
        stance _x
    ];
} forEach (units _obj_group);

// Delete all units in the given group
if !(local _obj_group) then {
    [_obj_group] remoteExec ["shoothouse_fnc_deleteGroup", owner _obj];
} else {
    [_obj_group] call shoothouse_fnc_deleteGroup;
};

_group_array