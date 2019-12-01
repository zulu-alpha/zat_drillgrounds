/*

    Author: Phoenix of Zulu-Alpha

    Description: Process each unit inside the target unit's group and return group arrays.

    Params:
        0: OBJECT - Object that represents the a group (soldier) of targets.

    Returns: ARRAY - Nested Arrays of format [ [<class name string>, ...], [[<position atl array>, <direction number>, <stance string>], ...] ]

*/

params ["_obj"];

private _obj_group = group _obj;

// Remember the group to avoid processing it again or quit if already processed
// Also if processing a unit which was just deleted as another unit in it's group was 
// already processed.
if ((isNull _obj_group) or {_obj_group in shoothouse_var_processed_groups}) exitWith {};
shoothouse_var_processed_groups pushBack _obj_group;

// Store type/side seperate from locations.
private _group_type_array = [];
private _group_pos_array = [];
{
    _group_type_array pushBack (typeOf _x);
    _group_pos_array pushBack 
    [
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

[_group_type_array, _group_pos_array]