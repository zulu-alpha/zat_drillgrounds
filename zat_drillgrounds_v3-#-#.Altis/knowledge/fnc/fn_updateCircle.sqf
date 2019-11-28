/*

    Author: Phoenix of Zulu-Alpha

    Description: Creates or updates the circle for the given group player combination.

    Params:
		0: STRING  - NetID of Group
		1: STRING - NetID of Player
		2: ARRAY - Postional array of beleived player position
		3: NUMBER - Error of beleived player position
		4: OBJECT - Object containing namespace for circles
		5: OBJECT - Object containing namespace for last known positions and errors

    Returns: None

*/
params [
	"_group_ID",
	"_player_ID",
	"_target_position",
	"_position_error",
	"_circles_namespace",
	"_lastPosError_namespace"
];

private _var_name_lastPosError = format [
	"knowledge_lastPosError_%1_for_%2",
	_group_ID,
	_player_ID
];
private _var_name_circles = format [
	"knowledge_circleObjects_%1_for_%2",
	_group_ID,
	_player_ID
];

private _last_posError = _lastPosError_namespace getVariable [
	_var_name_lastPosError,
	[[0,0,0],0]
];
_last_posError params ["_last_pos", "_last_error"];
_last_pos params ["_last_x", "_last_y", "_last_z"];

if (
	(_target_position select 0 != _last_x) or 
	{_target_position select 1 != _last_y} or 
	{_target_position select 2 != _last_z} or 
	{_position_error != _last_error}
) then {
	[_var_name_circles, _circles_namespace] call knowledge_fnc_deleteCircle;
	_circles_namespace setVariable [
		_var_name_circles, 
		[_target_position, _position_error] call knowledge_fnc_createCircle
	];
	_lastPosError_namespace setVariable [
		_var_name_lastPosError, 
		[_target_position, _position_error]
	];
};
