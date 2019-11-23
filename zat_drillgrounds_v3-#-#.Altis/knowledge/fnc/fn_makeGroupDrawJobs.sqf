/*

    Author: Phoenix of Zulu-Alpha

    Description: Makes a draw job based on the knowledge that the given group has for the 
	             given unit.

    Params:
        0: OBJECT - Group.
		1: OBJECT - Unit of whom knowledge must be gotten for.

    Returns:
		ARRAY - Of format:
			_knows_about_level,
			_known_by_unit,
			_last_seen,
			_last_endangered,
			_target_side

*/

params ["_group", "_player"];

private _leader = leader _group;
private _data = _group getVariable [
	format ["knowledge_of_%1", _player call BIS_fnc_netId],
	isNil
];
if (isNil "_group") exitWith {};
_data params [
	"_is_group_empty",
	"_knows_about_level",
	"_known_by_group",
	"_known_by_unit",
	"_last_seen",
	"_last_endangered",
	"_target_side",
	"_position_error",
	"_target_position"
];
if (
	_is_group_empty or
	{!(_known_by_group or _known_by_unit)} or
	{}
) exitWith {};

if ((_known_by_group or _known_by_unit) and {_knows_about_level > 0} and {alive _x}) then {
	_knowledge pushBack [
		_x,
		_knows_about_level,
		_known_by_unit,
		_last_seen,
		_last_endangered,
		_target_side,
		_position_error,
		_target_position
	];
};


