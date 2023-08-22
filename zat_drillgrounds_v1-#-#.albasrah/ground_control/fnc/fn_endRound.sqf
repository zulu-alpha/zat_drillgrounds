/*
	Description:
	End the round for the ground control course and prepare it for a new round.
	Must be executed on server

	Parameter(s):
	0: OBJECT - Course control object.

	Returns:
	Nothing
*/
params ["_course"];

private _spawners = _course getVariable ["groundControl_spawners", []];
private _enemy_groups = _course getVariable ["groundControl_enemyGroups", []];
private _objectives = _course getVariable ["groundControl_objectives", []];

{
	_x setDamage 0;
} forEach _spawners;

{
	private _group = _x;
	{
		deleteVehicle _x
	} forEach units _group ;
	deleteGroup _group ;
} forEach _enemy_groups;

// Make all objective areas neutral
{
    [_x] call groundControl_fnc_processObjectiveArea;  
} forEach _objectives;

_course setVariable ["groundControl_enemyGroups", [], false];
_course setVariable ["groundControl_isActive", false, true];
