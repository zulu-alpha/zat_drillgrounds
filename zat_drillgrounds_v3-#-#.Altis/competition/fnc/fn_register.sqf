/*

    Author: Phoenix of Zulu-Alpha

    Description: Designate the role of the object and initiate the whole system.

    Params:
        0: OBJECT - Course object (Normally game logic).
        1: STRING - The role of the object. Options are "start", or "stage". Not case sensitive.
		2: CODE - Set-up code, to be executed when the course starts or a stage is reached.
		2: CODE - Tear-down code, to be executed when the start or stage is finished.

    Returns: None

*/

if !(isServer) exitWith {};

params ["_course_object", "_role", "_setup", "_teardown"];

_role = toLower _role;

if !(_role in ["start", "stage"]) exitWith {
	diag_log format [
		"competition_fnc_register: Error, unknown role %1 used for object %2",
		_role,
		_course_object
	];
};

_course_object setVariable ["competition_role", _role];
_course_object setVariable ["competition_setup", _setup];
_course_object setVariable ["competition_teardown", _teardown];

if (_role == "start") then {
	[_course_object, _course_object] call competition_fnc_recurse;
};
