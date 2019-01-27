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
_groups = _course getVariable ["shoothouse_groups", []];

// Don't spawn if there are still active groups
if ( count (_course getVariable ["shoothouse_groups_active", []]) > 0 ) exitWith {diag_log "shootHouse: Error, course still active"};

// Number to spawn
private _num_pool = count _groups;
private _num_spawn = round(_num_pool * _ratio);

// Hint
private _message = parseText format [
    "<t align='center'>
    Spawning <t color='#ffff00'>%2</t> groups with settings:
    <br/>Live: <t color='#ffff00'>%3</t>
    <br/>Skill percentage: <t color='#ffff00'>%4%1</t>",
    "%",
    _num_spawn,
    _live,
    _skill * 100
];
[_message] remoteExec ["shoothouse_fnc_hint", owner _caller];

// Select groups to spawn
private _groups_pool_indexes = [];

// Run loop for as many times as there are groups to spawn
while {count _groups_pool_indexes < _num_spawn} do {

    // Randomly pick an index for the pool
    private _cur_index = round (random (_num_pool-1));

    // If the index not already picked, add
    if !(_cur_index in _groups_pool_indexes) then {
        _groups_pool_indexes set [count _groups_pool_indexes, _cur_index];
    };

};

// Populate spawn array using the random indexes of pool array of the correct amount
private _groups_spawn = [];
{
    _groups_spawn set [count _groups_spawn, _groups select _x];
} count _groups_pool_indexes;


// Spawn on server if no HCs
if (count shoothouse_var_hc_array == 0) exitWith {
    {
        [_course, [_live, _ratio, _skill], _x] call shoothouse_fnc_spawnGroup;
    } forEach _groups_spawn;
};

// or Spawn on HC if only one
if (count shoothouse_var_hc_array == 1) exitWith {
    {
        [_course, [_live, _ratio, _skill], _x] remoteExec ["shoothouse_fnc_spawnGroup", shoothouse_var_hc_array select 0];
    } forEach _groups_spawn;
};

// Else spawn on multiple HCs using balancing algorithm
// Make array of num of local units for each HC that will use shoothouse_var_hc_array as index
private _will_haves = [];
{
    _will_haves set [count _will_haves, 0];
} count shoothouse_var_hc_array;

// This array for counting how many to actually spawn
private _to_spawns = +_will_haves;

// Count number of existing local units
{
    private _idx = shoothouse_var_hc_array find (owner _x);
    if (_idx > -1) then {
        _will_haves set [_idx, (_will_haves select _idx) + 1];
    };
} count allUnits;

// Add one of each for each group that needs to be spawned to the hc that currently
// has the fewest in _will_haves (to know where the fewest will be after each add)
// and to _to_spawns (to know how many to actually spawn).

for "_i" from 1 to (_num_spawn) do {

    // Find the hc with the smallest number
    private _idx_smallest = 0;
    private _smallest = 9999;
    {
        private _curr = _will_haves select _forEachIndex;
        if (_curr < _smallest) then {
            _smallest = _curr;
            _idx_smallest = _forEachIndex;
        };
    } forEach _will_haves;

    // Add one to the smallest for both arrays
    _will_haves set [_idx_smallest, _smallest + 1];
    _to_spawns set [_idx_smallest, (_to_spawns select _idx_smallest) + 1];

};


// Spawn the appropriate number of AI groups needed for each HC
private _group_index = 0;
diag_log str(_groups_spawn);
{

    for "_i" from 1 to (_to_spawns select _forEachIndex) do {
        [_course, [_live, _ratio, _skill], _groups_spawn select _group_index] remoteExec ["shoothouse_fnc_spawnGroup", _x];
        _group_index = _group_index + 1;
        diag_log str(_group_index);
    };

} forEach shoothouse_var_hc_array;
