/*

    Author: Phoenix of Zulu-Alpha

    Description: Creates or updates the circle for the given group player combination.

    Params:
		0: STRING  - NetID of Group
		1: OBJECT - Target player
		2: ARRAY - Postional array of beleived player position
		3: NUMBER - Error of beleived player position

    Returns: None

*/
params ["_group_ID", "_player", "_target_position", "_position_error"];

private _var_name_lastPosError = format ["knowledge_lastPosError_from_%1", _group_ID];
private _last_posError = _player getVariable [_var_name_lastPosError, [[0,0,0],0]];
_last_posError params ["_last_pos", "_last_error"];
_last_pos params ["_last_x", "_last_y", "_last_z"];

if (
	(_target_position select 0 != _last_x) or 
	{_target_position select 1 != _last_y} or 
	{_target_position select 2 != _last_z} or 
	{_position_error != _last_error}
) then {
	[_group_ID, _player] call knowledge_fnc_deleteCircle;
	_player setVariable [
	format ["knowledge_circleObjects_from_%1", _group_ID], 
		[_target_position, _position_error] call knowledge_fnc_createCircle
	];
	_player setVariable [
		_var_name_lastPosError, [_target_position, _position_error], false
	];
};
