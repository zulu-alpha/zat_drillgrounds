/*

    Author: Phoenix of Zulu-Alpha

    Description: Opens, closes or randomizes all doors in given building.
                 Can also randomize doors so that some are partially open.

    Params:
        0: OBJECT - Building
        1: STRING - "open", "close", "random", "random-partial"

    Returns: None

*/

params ["_building", "_action"];

private _open = "open";
private _close = "close";
private _random = "random";
private _random_partial = "random-partial";

// 1 is open, 0 close and -1 if neither
private _phase = -1;
if (_action == _open) then {_phase = shoothouse_var_door_open};
if (_action == _close) then {_phase = shoothouse_var_door_close};


// Get config file for each door
private _door_configs = "true" configClasses (configfile >> "CfgVehicles" >> (typeOf _building) >> "AnimationSources");
if (count _door_configs == 0) exitWith {diag_log "fn_operateDoors error: No doors found"};  // Exit if no doors found

// Sometimes animate works, other times animateSource works
// This depends on if source config entry exists for door in AnimationSources
// Assume all doors in the same building use the same command
private _config_source = [(_door_configs select 0), "source", "Nothing found"] call BIS_fnc_returnConfigEntry;
private _use_animateSource = if (_config_source != "Nothing found") then {true} else {false};

diag_log format ["fn_operateDoors info: Because source is %1, using animateSource is %2", _config_source, _use_animateSource];

// Get their names
private _door_names = [];
{

    private _door_name = configName _x;
    // Filter doors to make sure they are valid
    private _valid = false;
    // Whitelist: Make sure has whitelist word to make sure is door
    {
        private _result = [_door_name, _x] call CBA_fnc_find;
        if (_result != -1) exitWith {_valid = true; diag_log format ["fn_operateDoors info: %1 whitelisted because of %2!", _door_name, _x]};
    } forEach shoothouse_var_door_whitelist;
    if (_valid) then {
        // Blacklist: Eliminate if has word that marks it as something other than a normal open/close door action
        {
            private _result = [_door_name, _x] call CBA_fnc_find;
            if (_result != -1) exitWith {_valid = false; diag_log format ["fn_operateDoors info: %1 blacklisted because of %2!", _door_name, _x]};
        } forEach shoothouse_var_door_blacklist;
    };
    if (_valid) then {
        _door_names set [count _door_names, _door_name]
    };

} forEach _door_configs;

diag_log format ["fn_operateDoors info: Doors: %1", _door_names];

// Go through each door
{

    // Handle random cases
    if (_action == _random) then {_phase = round (random 1)};
    if (_action == _random_partial) then {_phase = random 1};
    if (_phase == -1) exitWith {diag_log format ["fn_operateDoors error: input action '%1' gave door phase of -1", _action]};
    diag_log format ["Using door phase of %1 for %2", _phase, _x];
    if (_use_animateSource) then {
        _building animateSource [_x, _phase, 1];
    } else {
        _building animate [_x, _phase, 1];
    };

} forEach _door_names;