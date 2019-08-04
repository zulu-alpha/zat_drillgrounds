/*

    Author: Phoenix of Zulu-Alpha

    Description: Creates the addaction menu items for the client and cleans old menu items if provided.
                 Designed firstly to be called from addaction, hence parameter structure

    Params:
        0: OBJECT - Object to add addaction menu items to
        1: OBJECT - Caller (use ObjNull when calling from server)
        2: NUMBER - ID number of addaction being called from (use -1 when not calling from addaction)
        3: ARRAY - Extra arguments of format: [<addaction NUMBERs to remove>, <course OBJECT>]

    Returns: None

*/

if !(hasInterface) exitWith {};

params ["_interface", "_caller", "_old_action", ["_action_args", [[], objNull]]];

_action_args params ["_old_action_trash", "_course"];
private _action_trash = [];


// Validate course object
if (isNull _course) exitWith {hint "shootHouse: Error, no course object"};

// Clean old action menu items
{
    _interface removeAction _x;
} count _old_action_trash;


private _is_not_active = "count ((_target getVariable ['shoothouse_courseObject', objNull]) getVariable ['shoothouse_groups_active', []]) == 0";
private _is_active = "count ((_target getVariable ['shoothouse_courseObject', objNull]) getVariable ['shoothouse_groups_active', []]) > 0";


_action = _interface addAction [
    ("<t color=""#FFBF00"">" + ("Target Settings") + "</t>"),
    shootHouse_fnc_targetSettings_0_live,
    [_action_trash, _course],
    1.5,
    true,
    true,
    "",
    _is_not_active];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#FFBF00"">" + ("Spawn targets") + "</t>"),
    {[(_this select 3) select 0, _this select 1] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];},
    [_course],
    1.5,
    true,
    true,
    "",
    _is_not_active];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#FFBF00"">" + ("Delete targets") + "</t>"),
    {[(_this select 3) select 0, _this select 1] remoteExec ["shootHouse_fnc_requestDeleteGroups", 2];},
    [_course],
    1.5,
    true,
    true,
    "",
    _is_active];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#013ADF"">" + ("Make yourself captive") + "</t>"),
    {[(_this select 3) select 0, _this select 1] call shootHouse_fnc_switchCaptive},
    [_course],
    1.5,
    true,
    true,
    "",
    "!(captive _this)"];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#FFBF00"">" + ("Paintball mode menu") + "</t>"),
    shootHouse_fnc_paintball_createMenu,
    [_action_trash, _course],
    1.5,
    true,
    true,
    "",
    _is_not_active];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#013ADF"">" + ("Stop being captive") + "</t>"),
    {[(_this select 3) select 0, _this select 1] call shootHouse_fnc_switchCaptive},
    [_course],
    1.5,
    true,
    true,
    "",
    "captive _this"];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#01DF01"">" + ("Open all doors") + "</t>"),
    {[(_this select 3) select 0, "open"] remoteExec ["shootHouse_fnc_requestOperateDoors", 2];},
    [_course],
    1.5,
    true,
    true,
    "",
    _is_not_active];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#01DF01"">" + ("Close all doors") + "</t>"),
    {[(_this select 3) select 0, "close"] remoteExec ["shootHouse_fnc_requestOperateDoors", 2];},
    [_course],
    1.5,
    true,
    true,
    "",
    _is_not_active];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#01DF01"">" + ("Randomize all doors") + "</t>"),
    {[(_this select 3) select 0, "random"] remoteExec ["shootHouse_fnc_requestOperateDoors", 2];},
    [_course],
    1.5,
    true,
    true,
    "",
    _is_not_active];
_action_trash set [count _action_trash, _action];

_action = _interface addAction [
    ("<t color=""#01DF01"">" + ("Randomize (partially open) all doors") + "</t>"),
    {[(_this select 3) select 0, "random-partial"] remoteExec ["shootHouse_fnc_requestOperateDoors", 2];},
    [_course],
    1.5,
    true,
    true,
    "",
    _is_not_active];
_action_trash set [count _action_trash, _action];
