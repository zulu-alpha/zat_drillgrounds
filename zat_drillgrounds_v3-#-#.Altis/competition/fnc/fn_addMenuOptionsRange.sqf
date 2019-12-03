/*

    Author: Phoenix of Zulu-Alpha

    Description: Add the standard set of addaction menu options (MVP now).

    Params:
        0: OBJECT - Control object 

    Returns: None

*/

if !(hasInterface) exitWith {};

params ["_control_object"];

_control_object addAction [
    "Start course",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_caller] remoteExec ["competition_fnc_range", 2];
        [range_course, _caller, false] call paintball_fnc_addParticipant;
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(range_course getVariable ['course_isActive', false])"
];

_control_object addAction [
    "Cancel course run",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_caller, true] remoteExec ["competition_fnc_rangeCleanup", 2];
        [range_course, _caller, false] call paintball_fnc_removeParticipant;
    },
    nil,
    1.5,
    true,
    true,
    "",
    "range_course getVariable ['course_isActive', false]"
];
