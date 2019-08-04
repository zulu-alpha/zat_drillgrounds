/*
Author:
	Phoenix

Files:
	move\move_init.sqf (this file)
	move\move.sqf
	move\min_rank.sqf

Purpose:
	This is used to create teleporters that automatically detect other teleporters and add's them as options.

Params:
	0: Object: (usually 'this' when executed from init field in the editor)
	1: String: Name of teleporter (will appear in addaction list at other teleporters)
	2: String (Optional): Color of the addaction menu item. Eg: "#ff0000"
	3: String (Optional): Minimum rank required by a player to use the teleporter. Default: "PRIVATE"

Example:
	nul = [this, "OP-1", "#ff0000", "CORPORAL"] execVM "move\move_init.sqf";

Ranks:
	"PRIVATE"
	"CORPORAL"
	"SERGEANT"
	"LIEUTENANT"
	"CAPTAIN"
	"MAJOR"
	"COLONEL"

*/

private ["_tele_name", "_tele_colour_source", "_tele_colour", "_min_rank", "_rank", "_has_permission", "_tele_no"];

waitUntil {sleep 1; time > 2};
if !hasInterface exitWith {};
waitUntil {sleep 1; !(isNull player)};

_teleporter = _this select 0;
_tele_name = _this select 1;
_tele_colour_source = if (count _this > 2) then {_this select 2} else {"#fadfbe"};
_tele_colour = format ["<t color=""%1"">", _tele_colour_source];
_min_rank = if (count _this > 3) then {_this select 3} else {"PRIVATE"};
_rank = rank player;

// Check if player has min rank.
_has_permission = [_rank, _min_rank] call compile preprocessFileLinenUmbers "move\min_rank.sqf";
if !_has_permission exitWith {};

// Add teleporter to list.
if (isNil "teleporters") then {teleporters = []};
teleporters set [count teleporters, [_teleporter, _tele_name, _tele_colour]];

// Wait for all teleporters to be initialized.
sleep 4;

// Add all teleporters from the list as options to teleport to in the addaction list.
_tele_no = (count teleporters) - 1;
private ["_teleporter"];
for "_i" from 0 to _tele_no do {
	if !(_teleporter in (teleporters select _i)) then {
		_teleporter addaction [(((teleporters select _i) select 2) + ((teleporters select _i) select 1) + "</t>"), "move\move.sqf",[(teleporters select _i) select 0]];
	};
};