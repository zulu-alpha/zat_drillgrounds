/*

    Author: Phoenix of Zulu-Alpha

    Description: Choose whether the targets should be live or not.
                 Designed firstly to be called from addaction, hence parameter structure

    Params:
    0: OBJECT - Object to add addaction menu items to
    1: OBJECT - Caller (use ObjNull when calling from server)
    2: NUMBER - ID number of addaction being called from (use -1 when not calling from addaction)
    3: ARRAY - Extra arguments of format: [<addaction NUMBERs to remove>, <course OBJECT>]

    Returns: None

*/

params ["_interface", "_caller", "_old_action", ["_action_args", [[], objNull]]];

_action_args params ["_old_action_trash", "_course"];
private _action_trash = [];


// Validate course object
if (isNull _course) exitWith {hint "shootHouse: Error, no course object"};

// Clean old action menu items
{
    _interface removeAction _x;
} count _old_action_trash;

_course getVariable ["shoothouse_settings_target", []] params ["_live", "_ratio", "_skill"];


hint parseText format [
    "<t align='center'>
    Choose whether the targets should be live or not.
    <br/>
    <br/>Current settings:
    <br/>Live: <t color='#ffff00'>%2</t>
    <br/>Percentage of possible targets: <t color='#ffff00'>%3%1</t>
    <br/>Skill percentage: <t color='#ffff00'>%4%1</t>",
    "%",
    _live,
    _ratio * 100,
    _skill * 100
];


_action = _interface addAction[("<t color=""#FFBF00"">" + ("Safe") + "</t>"), shootHouse_fnc_targetSettings_1_percentage, [_action_trash, _course, false]];
_action_trash set [count _action_trash, _action];

_action = _interface addAction[("<t color=""#FFBF00"">" + ("Live") + "</t>"), shootHouse_fnc_targetSettings_1_percentage, [_action_trash, _course, true]];
_action_trash set [count _action_trash, _action];


_action = _interface addAction[("<t color=""#FF0000"">" + ("Main Menu") + "</t>"), shootHouse_fnc_createMenu, [_action_trash, _course]];
_action_trash set [count _action_trash, _action];
