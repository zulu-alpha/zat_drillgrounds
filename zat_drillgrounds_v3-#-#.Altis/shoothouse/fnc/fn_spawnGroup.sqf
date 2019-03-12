/*

    Author: Phoenix of Zulu-Alpha

    Description: Spawns each target in given group according to given settings and registers the group with the server for tracking and each target to the group (in case of error).

    Params:
        0: OBJECT - Course object
        1: ARRAY - Target settings of format [<if live or not BOOL>, <ratio of targets to spawn NUMBER>, <skill NUMBER>]
        2: ARRAY - Group to spawn, each of format [[<class name string>, <SIDE>, <position atl array>, <direction number>, <stance string>]]

    Returns: None

*/

params ["_course", "_settings", "_group_array"];
_settings params ["_live", "_ratio", "_skill"];

private _side = (_group_array select 0) select 1;  // Use first target of group for it's side
private _target_group = createGroup _side;

{

    _x params ["_class", "_side", "_pos", "_dir", "_stance"];

    private _target_object = _target_group createUnit [_class, _pos, [], 0, "NONE"];
    _target_object disableAI "PATH";
    _target_object setPosATL _pos;
    _target_object setFormDir _dir;
    _target_object setDir _dir;
    (group _target_object) setBehaviour "SAFE";

    // Live setting
    if !(_live) then {
        _target_object setCombatMode "BLUE";
    };

    // Skill setting
    _target_object setSkill _skill;

    // Unit Pos
    _unitPos_mapping_index = shoothouse_var_stance_mapping find _stance;
    private _unitPos = if (_unitPos_mapping_index >= 0) then {
            shoothouse_var_unitPos_mapping select _unitPos_mapping_index
        } else {
            "AUTO"
    };
    _target_object setUnitPos _unitPos;

} forEach _group_array;

// VCOM
{
    _target_group setVariable [_x, true];
} forEach ["VCM_NOFLANK", "VCM_NORESCUE", "VCM_TOUGHSQUAD"];


// Register group with server. Use thread in order to ensure that registration is successfull
// Also exit with warning after 5 tries
[_course, _target_group] spawn {
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
