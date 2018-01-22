/*

    Author: Phoenix of Zulu-Alpha

    Description: Handles the client request to open, close or randomize all doors in course.
                 Can also randomize doors so that some are partially open.

    Params:
        0: OBJECT - Course
        1: STRING - "open", "close", "random", "random-partial"

    Returns: None

*/

params ["_course", "_action"];

// Perform action for each separate door object and building
{
    diag_log format ["fn_requestOperateDoors info: %1 being processed", _x];
    [_x, _action] call shoothouse_fnc_operateDoors;
} forEach ( (_course getVariable ["shoothouse_doors", []]) + (_course getVariable ["shoothouse_buildings", []]));
