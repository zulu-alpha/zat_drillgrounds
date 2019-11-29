/*

    Author: Phoenix of Zulu-Alpha

    Description: Process synced objects; Men as targets, info stands as interfaces and options for doors

    Params:
        0: OBJECT - Object that has objects synchronized to it.

    Returns: None

*/

if !(isServer) exitWith {};

params ["_course"];

private _interfaces = [];
private _groups = [];
private _doors = [];
private _buildings = [];

{

    private _sync_x = _x;
    private _found = False;

    // Deleted
    if (isNull _sync_x) then {
        _found = True;
    };

    // Targets
    if !(_found) then {
        {
            if (_sync_x isKindOf _x) exitWith {
                private _group_array = [_sync_x] call shoothouse_fnc_processTarget;
                if !(isNil {_group_array}) then {
                    _groups pushBack (_group_array);
                };
                _found = True;
            };
        } count shoothouse_var_classes_target;
    };

    // Doors
    if !(_found) then {
        {
            if (_sync_x isKindOf _x) exitWith {
                _doors pushBack _sync_x;
                _found = True;
            };
        } count shoothouse_var_classes_door;
    };

    // Interfaces
    if !(_found) then {
        {
            if (_sync_x isKindOf _x) exitWith {
                _interfaces pushBack _sync_x;
                _found = True;
            };
        } count shoothouse_var_classes_interface;
    };

    // Building, if nothing else
    if !(_found) then {
        _buildings set [count _buildings, _sync_x];  // Strange bug (Error Type Number, expected Bool) when using pushBack
    };

} count synchronizedObjects _course;

_course setVariable ["shoothouse_interfaces", _interfaces];
_course setVariable ["shoothouse_groups", _groups];
_course setVariable ["shoothouse_doors", _doors];
_course setVariable ["shoothouse_buildings", _buildings];

_course setVariable ["shoothouse_settings_target", shoothouse_var_settings_target, true];

// Add addaction menu items to each interface for each player
{
    [_x, objNull, -1, [[], _course]] remoteExec ["shootHouse_fnc_createMenu", 0, true];
    // Add reference to course object from iterface
    _x setVariable ["shoothouse_courseObject", _course, true];
} forEach _interfaces;
