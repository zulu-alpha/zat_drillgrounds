/*

    Author: Phoenix of Zulu-Alpha

    Description: Create addaction options for enabling, disabling, or viewing scores of 
                 Paintball mode.

    Params:
        0: OBJECT - Control object 

    Returns: None

*/

if !(hasInterface) exitWith {};

params ["_control_object"];

_control_object addAction [
    ("<t color=""#013ADF"">" + ("Enable paintball mode") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target, _caller, true] call paintball_fnc_addParticipant
    },
    nil,
    1.5,
    true,
    true,
    "",
    "!(_this in (_target getVariable ['paintballers', []]))"];

_control_object addAction [
    ("<t color=""#013ADF"">" + ("Disable paintball mode") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target, _caller, true] call paintball_fnc_removeParticipant
    },
    nil,
    1.5,
    true,
    true,
    "",
    "_this in (_target getVariable ['paintballers', []])"];

_control_object addAction [
    ("<t color=""#013ADF"">" + ("Show scores") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target] call paintball_fnc_hintScores
    }
];

_control_object addAction [
    ("<t color=""#013ADF"">" + ("Clear scores") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target] call paintball_fnc_clearScores
    }
];
