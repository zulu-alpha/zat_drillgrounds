/*

    Author: Phoenix of Zulu-Alpha

    Description: Create addaction options for enabling, disabling, or viewing scores of Paintball mode.
                 Designed firstly to be called from addaction, hence parameter structure

    Params:
    0: OBJECT - Object to add addaction menu items to
    1: OBJECT - Caller (use ObjNull when calling from server)
    2: NUMBER - ID number of addaction being called from (use -1 when not calling from addaction)
    3: ARRAY - Extra arguments of format: [<addaction NUMBERs to remove>, <course OBJECT>, <ratio NUMBER>]

    Returns: None

*/

params ["_interface", "_caller", "_old_action", ["_action_args", [[], objNull]]];

_action_args params ["_old_action_trash", "_course", "_ratio_new"];
private _action_trash = [];


// Validate course object
if (isNull _course) exitWith {hint "shootHouse: Error, no course object"};

// Clean old action menu items
{
    _interface removeAction _x;
} count _old_action_trash;


_action = _interface addAction [
    ("<t color=""#013ADF"">" + ("Enable paintball mode") + "</t>"),
    {[(_this select 3) select 0, _this select 1] call shootHouse_fnc_paintball_addParticipant},
    [_course],
    1.5,
    true,
    true,
    "",
    "isDamageAllowed _this"];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#013ADF"">" + ("Disable paintball mode") + "</t>"),
    {[(_this select 3) select 0, _this select 1] call shootHouse_fnc_paintball_removeParticipant},
    [_course],
    1.5,
    true,
    true,
    "",
    "!(isDamageAllowed _this)"];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#013ADF"">" + ("Show scores") + "</t>"),
    {[(_this select 3) select 0] call shootHouse_fnc_paintball_hintScores},
    [_course],
    1.5,
    true,
    true,
    "",
    "true"];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#013ADF"">" + ("Clear scores") + "</t>"),
    {[(_this select 3) select 0] call shootHouse_fnc_paintball_clearScores},
    [_course],
    1.5,
    true,
    true,
    "",
    "true"];
_action_trash set [count _action_trash, _action];

_action = _interface addAction[("<t color=""#FF0000"">" + ("Main Menu") + "</t>"), shootHouse_fnc_createMenu, [_action_trash, _course]];
_action_trash set [count _action_trash, _action];
