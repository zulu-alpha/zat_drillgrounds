/*
*	Author: Phoenix
* 	Description: Give addactions for Billboard for formations area.
* 	Usage:
*		See set_formations.sqf usage for variable names to use for reference objects and billboard
*		Add this to the init field of the billboard or any object used to control formations: 
*			nul = [this] execVM "formations\init.sqf";
*/

params ["_controller"];

private _set_formation = compileFinal preprocessFileLineNumbers "formations\set_formation.sqf";

_controller addaction ["Column", _set_formation, "column"];
_controller addaction ["Staggered Column", _set_formation, "staggered_column"];
_controller addaction ["Line Right", _set_formation, "line_right"];
_controller addaction ["Line Left", _set_formation, "line_left"];
_controller addaction ["Line facing Right", _set_formation, "line_facing_right"];
_controller addaction ["Line facing Left", _set_formation, "line_facing_left"];
_controller addaction ["Wedge Left", _set_formation, "wedge_left"];
_controller addaction ["Wedge Right", _set_formation, "wedge_right"];
_controller addaction ["Go Firm", _set_formation, "go_firm"];
_controller addaction ["Wall Formation", _set_formation, "wall_formation"];