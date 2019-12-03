// Add addaction menu items to each interface for each player
{
    [_x, objNull, -1, [[], _course]] remoteExec ["competition_fnc_createMenu", 0, true];
    // Add reference to course object from iterface
    _x setVariable ["competition_startObject", _course, true];
} forEach _interfaces;


(typeof trg) isKindOf "EmptyDetector"


this addAction [
    "Start course",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_caller] remoteExec ["competition_fnc_range", 2];
        hint "Your course has started!";
        [range_course, _caller, false] call paintball_fnc_addParticipant;
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(range_course getVariable ['course_isActive', false])"
];

this addAction [
    "Start course",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_caller] remoteExec ["competition_fnc_range", 2];
        hint "Your course has started!";
        [range_course, _caller, false] call paintball_fnc_addParticipant;
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(range_course getVariable ['course_isActive', false])"
];