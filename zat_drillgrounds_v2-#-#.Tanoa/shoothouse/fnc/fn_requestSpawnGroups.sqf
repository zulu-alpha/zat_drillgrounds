/*

    Author: Phoenix of Zulu-Alpha

    Description: Spawns given groups on the correct machine for course object.

    Params:
        0: OBJECT - Course object
        1: OBJECT - Caller of script for notifying

    Returns: None

*/

params ["_course", "_caller"];

_course getVariable ["shoothouse_settings_target", []] params ["_live", "_ratio", "_skill"];
private _group_arrays = _course getVariable ["shoothouse_group_arrays", []];

// Don't spawn if there are still active groups
if ( count (_course getVariable ["shoothouse_groups_active", []]) > 0 ) exitWith {diag_log "shootHouse: Error, course still active"};

// Hint
private _total_units = 0;
{
    _x params ["_types", "_positions"];
    _total_units = _total_units + round (count _positions * _ratio);  // multiplying ratio here to account for rounding errors
} forEach (_group_arrays);

private _message = parseText format [
    "<t align='center'>
    Creating <t color='#ffff00'>%2</t> targets with settings:
    <br/>Live: <t color='#ffff00'>%3</t>
    <br/>Skill percentage: <t color='#ffff00'>%4%1</t>",
    "%",
    _total_units,
    _live,
    _skill * 100
];
[_message] remoteExec ["shoothouse_fnc_hint", owner _caller];

// Spawn on server if no HCs
if (count shoothouse_var_hc_array == 0) exitWith {
    {
        [_course, [_live, _ratio, _skill], _x, _ratio] call shoothouse_fnc_spawnGroup;
    } forEach _group_arrays;
};

// or Spawn on HC if only one
if (count shoothouse_var_hc_array == 1) exitWith {
    {
        [
            _course,
            [_live, _ratio, _skill],
            _x,
            _ratio
        ] remoteExec ["shoothouse_fnc_spawnGroup", shoothouse_var_hc_array select 0];
    } forEach _group_arrays;
};

// Else spawn on multiple HCs using balancing algorithm
// Make an array, where each index maps to the index of shoothouse_var_hc_array for each
// HC, and each value at that index will be the total number of groups that the HC will eventually have.
private _will_haves = [];
{
    _will_haves pushBack 0;
} forEach shoothouse_var_hc_array;

// This array is for counting how many to spawn for each HC
private _to_spawns = +_will_haves;

// Count number of existing groups that are local to each HC
{
    private _idx = shoothouse_var_hc_array find (groupOwner _x);
    if (_idx > -1) then {
        _will_haves set [_idx, (_will_haves select _idx) + 1];
    };
} forEach allGroups;

// Add one of each group that needs to be spawned to the hc that currently
// has the fewest in _will_haves (to know where the fewest will be after each add)
// and to _to_spawns to know how many to actually spawn.
for "_i" from 1 to (count _group_arrays) do {

    // Find the hc with the smallest number
    private _idx_smallest = 0;
    private _smallest_group_count = 9999;
    {
        private _current_group_count = _will_haves select _forEachIndex;
        if (_current_group_count < _smallest_group_count) then {
            _smallest_group_count = _current_group_count;
            _idx_smallest = _forEachIndex;
        };
    } forEach _will_haves;

    // Increment the will have and to spawn arrays by one for the HC with the lightest burden.
    _will_haves set [_idx_smallest, _smallest_group_count + 1];
    _to_spawns set [_idx_smallest, (_to_spawns select _idx_smallest) + 1];

};

diag_log format ["shoothouse_fnc_requestSpawnGroups: shoothouse_var_hc_array %1", shoothouse_var_hc_array];
diag_log format ["shoothouse_fnc_requestSpawnGroups: _will_haves %1", _will_haves];
diag_log format ["shoothouse_fnc_requestSpawnGroups: _to_spawns %1", _to_spawns];

// Spawn the appropriate number of AI groups needed for each HC
private _group_index = 0;
{

    for "_i" from 1 to (_to_spawns select _forEachIndex) do {
        [
            _course,
            [_live, _ratio, _skill],
            _group_arrays select _group_index,
            _ratio
        ] remoteExec ["shoothouse_fnc_spawnGroup", _x];
        _group_index = _group_index + 1;
        diag_log format ["shoothouse_fnc_requestSpawnGroups: _group_index %1", _group_index];
    };

} forEach shoothouse_var_hc_array;
