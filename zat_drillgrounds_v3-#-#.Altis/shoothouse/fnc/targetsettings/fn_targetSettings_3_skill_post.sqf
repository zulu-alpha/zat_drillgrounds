/*

    Author: Phoenix of Zulu-Alpha

    Description: Saves skill setting.
                 Designed firstly to be called from addaction, hence parameter structure

    Params:
    0: OBJECT - Object to add addaction menu items to
    1: OBJECT - Caller (use ObjNull when calling from server)
    2: NUMBER - ID number of addaction being called from (use -1 when not calling from addaction)
    3: ARRAY - Extra arguments of format: [<addaction NUMBERs to remove>, <course OBJECT>, <skill NUMBER>]

    Returns: None

*/

params ["_interface", "_caller", "_old_action", ["_action_args", [[], objNull]]];

_action_args params ["_old_action_trash", "_course", "_skill_new"];
private _action_trash = [];


// Validate course object
if (isNull _course) exitWith {hint "shootHouse: Error, no course object"};

// Clean old action menu items
{
    _interface removeAction _x;
} count _old_action_trash;

_course getVariable ["shoothouse_settings_target", []] params ["_live", "_ratio", "_skill"];

// Save setting from last menu
_skill = _skill_new;
_course setVariable ["shoothouse_settings_target", [_live, _ratio, _skill], true];


hint parseText format [
    "<t align='center'>
    Current settings:
    <br/>Live: <t color='#ffff00'>%2</t>
    <br/>Percentage of targets to create: <t color='#ffff00'>%3%1</t>
    <br/>Skill percentage: <t color='#ffff00'>%4%1</t>",
    "%",
    _live,
    _ratio * 100,
    _skill * 100
];


[_interface, player, -1, [_action_trash, _course]] call shootHouse_fnc_createMenu;
