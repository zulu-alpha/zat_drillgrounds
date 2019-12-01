/*

    Author: Phoenix of Zulu-Alpha

    Description: Spawns each target in given group according to given settings and registers the group with the server for tracking and each target to the group (in case of error).

    Params:
        0: OBJECT - Course object
        1: ARRAY - Target settings of format [<if live or not BOOL>, <ratio of targets to spawn NUMBER>, <skill NUMBER>]
        2: ARRAY - Groups to spawn, each of format [ [<class name string>, ...], [[<position atl array>, <direction number>, <stance string>], ...] ]
        3: NUMBER - Ratio of units to spawn in the group

    Returns: None

*/

params ["_course", "_settings", "_group_arrays", "_ratio"];
_settings params ["_live", "_ratio", "_skill"];
_group_arrays params ["_group_types", "_group_positions"];

private _count_of_pool = (count _group_positions);
private _num_to_spawn = round (_count_of_pool * _ratio);
if (_num_to_spawn == 0) exitWith {};

private _unit_pool_indexes = [];
// Will keep selecting a random and unique index refernce for the group position array 
// until the correct number of them are selected.
while {count _unit_pool_indexes < _num_to_spawn} do {
    private _index = round (random (_count_of_pool - 1));
    _unit_pool_indexes pushBackUnique _index;
};

private _unit_positions_to_use = [];
{
    _unit_positions_to_use pushBack (_group_positions select _x);  // We work with group positions as that must be non repeated
} forEach _unit_pool_indexes;

/*
    Units of each side will be in a group of the side matching their config, but only one
    group of each side must be created.

    east = 0
    west = 1
    resistance = 2
    civilian = 3
*/
private _west_group = grpNull;
private _east_group = grpNull;
private _resistance_group = grpNull;
private _civilian_group = grpNull;

private _created_groups = [];
{

    private _type = selectRandom _group_types;
    _side_num = getNumber (configfile >> "CfgVehicles" >> _type >> "side");
    _group = switch (_side_num) do {
        case 0: {
            if (isNull _west_group) then {_west_group = createGroup west};
            _west_group
        };
        case 1: {
            if (isNull _east_group) then {_east_group = createGroup east};
            _east_group
        };
        case 2: {
            if (isNull _resistance_group) then {_resistance_group = createGroup resistance};
            _resistance_group
        };
        case 3: {
            if (isNull _civilian_group) then {_civilian_group = createGroup civilian};
            _civilian_group
        };
    };
    _x params ["_pos", "_dir", "_stance"];
    [_group, _type, _pos, _dir, _stance, _live, _skill] call shoothouse_fnc_spawnUnit;
    _created_groups pushBackUnique _group;

} forEach _unit_positions_to_use;

// Register each new group with the server. Use thread in order to ensure that 
// registration is successfull Also exit with warning after 5 tries.
{

    [_course, _x] spawn {
        params ["_course", "_target_group"];
        private _active = _course getVariable ["shoothouse_groups_active", []];
        private _try = 1;
        while {!(isNull _target_group) and {!(_target_group in _active)}} do {
            if (_try > 4) exitWith {
                private _message = format ["Warning, unregistered group in course %1", _course];
                [_message] remoteExec ["shoothouse_fnc_hint", 0]
            };
            _this remoteExec ["shoothouse_fnc_registerGroup", 2];
            _try = _try + 1;
            sleep 10;
            _active = _course getVariable ["shoothouse_groups_active", []];
        }
    };

} forEach _created_groups;