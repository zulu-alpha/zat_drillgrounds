/*

    Author: Phoenix of Zulu-Alpha

    Description: Gives a draw job array for the given data

    Params:
        0: OBJECT - Group to make draw jobs for.

    Returns:
		ARRAY - Nested array, where each array is of format:
			_knows_about_level,
			_known_by_unit,
			_last_seen,
			_last_endangered,
			_target_side

*/

params ["_group"];

private _leader = leader _group;
private _allKnowledgeOfPlayers = [];

if (count (units _group) == 0) exitWith {[]};

{

	private _var_name_for_unit = format ["knowledge_of_%1", _x call BIS_fnc_netId];

	private _data = _group getVariable [_var_name_for_unit, []];
	_data params [
		"_knows_about_level",
		"_known_by_group",
		"_known_by_unit",
		"_last_seen",
		"_last_endangered",
		"_target_side",
		"_position_error",
		"_target_position"
	];

	if ((_known_by_group or _known_by_unit) and {_knows_about_level > 0} and {alive _x}) then {
		_allKnowledgeOfPlayers pushBack [
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

} forEach (allPlayers - entities "HeadlessClient_F");

_allKnowledgeOfPlayers
