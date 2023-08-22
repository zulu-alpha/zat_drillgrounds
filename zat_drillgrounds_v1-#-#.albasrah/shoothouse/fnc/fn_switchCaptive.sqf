/*

    Author: Phoenix of Zulu-Alpha

    Description: Switches captivity for given unit and removes captive once global var for max distance is exceeded.
                 Must be run where object is local.

    Params:
        0: OBJECT - Course object
        1: OBJECT - Object to make captive

    Returns: None

*/

params ["_course", "_object"];

_object setCaptive !(captive _object);

private _message = if (captive _object) then {
    parseText format [
        "<t align='center'>
        You are now 'captive'. Remember to
        <br/>undo this when you run the course"
    ]
} else {
    parseText format [
        "<t align='center'>
        You are no longer 'captive'"
    ]
};
hint _message;

// Automatically make non captive if more than a certain distance away from course object
if (captive _object) then {
    [_course, _object] spawn {
        params ["_course", "_object"];
        // Make sure the check isn't already running
        private _run_check_var_name = "shoothouse_captive_distance_check_running";
        if (_object getVariable [_run_check_var_name, false]) exitWith {};
        _object setVariable [_run_check_var_name, true];
        // Wait until far enough away or no longer captive
        waitUntil {sleep 5; !(captive _object) or {(_object distance _course) > shoothouse_var_max_captive_distance}};
        // Remove captivity if no longer in range or do nothing if no longer captive
        if (captive _object) then {
            _object setCaptive false;
            private _message = parseText format [
                "<t align='center'>
                You are no longer 'captive' due to
                <br/>being farther than %1m away
                <br/>from the course.",
                shoothouse_var_max_captive_distance
            ];
            hint _message;
        };
        // Let future loops know this loop has ended.
        _object setVariable [_run_check_var_name, false];
    };
};