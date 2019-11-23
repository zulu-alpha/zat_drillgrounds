/*

    Author: Phoenix of Zulu-Alpha

    Description: Adds addaction options to the control object for the system.
				 It mutates the `knowledge_isActive` global variable publicly.

    Params:
        0: OBJECT - Control object 

    Returns: None

*/

if !(hasInterface) exitWith {};

params ["_control_object"];

_control_object addAction [
    "Enable knowledge system",
    {
        remoteExec ["knowledge_fnc_mainLoop", 0, true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(missionNamespace getVariable ['knowledge_isActive', false])"
];

_control_object addAction [
    "Disable knowledge system",
    {
        missionNamespace setVariable ["knowledge_isActive", false, true];
    },
    nil,
    1.5,
    true,
    true,
    "",
    "missionNamespace getVariable ['knowledge_isActive', false]"
];
