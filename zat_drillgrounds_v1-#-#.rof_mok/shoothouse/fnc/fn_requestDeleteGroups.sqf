/*

    Author: Phoenix of Zulu-Alpha

    Description: Deletes all spawned targets for the given course object by having their owner machine do the deleting.

    Params:
        0: OBJECT - Course object
        1: OBJECT - Caller of script for notifying

    Returns: None

*/

params ["_course", "_caller"];


private _active_groups = _course getVariable ["shoothouse_groups_active", []];
private _total_units = [_active_groups] call shoothouse_fnc_totalUnits;
private _count_active_groups = count _active_groups;

diag_log format ["fn_requestDeleteGroups.sqf: _count_active_groups %1", _count_active_groups];
diag_log format ["fn_requestDeleteGroups.sqf: _total_units %1", _total_units];

// Delete junk
{
    deleteVehicle _x;
} forEach (_course getVariable ["shoothouse_junk", []]);

// Delete groups
for "_i" from 0 to ((_count_active_groups) - 1) do {
    private _group_obj = _active_groups deleteAt 0;

    if !(isNull _group_obj) then {
        if !(local _group_obj) then {
            [_group_obj] remoteExec ["shoothouse_fnc_deleteGroup", groupOwner _group_obj];
        } else {
            [_group_obj] call shoothouse_fnc_deleteGroup;
        };
    };
};

// Hint
private _message = parseText format [
    "<t align='center'>
    Deleted <t color='#ffff00'>%1</t> groups and <t color='#ffff00'>%2</t> targets",
    _count_active_groups,
    _total_units
];
[_message] remoteExec ["shoothouse_fnc_hint", owner _caller];

_course setVariable ["shoothouse_groups_active", _active_groups, true];
