/*

    Author: Phoenix of Zulu-Alpha

    Description: Deletes the circle for the given group target combination.

    Params:
		0: STRING  - NetID of Group
		1: OBJECT - Target player

    Returns: None

*/
params ["_group_ID", "_player"];

private _var_name = format ["knowledge_circleObjects_from_%1", _group_ID];
{
	deleteVehicle _x;
} forEach (_player getVariable [_var_name, []]);

_player setVariable [_var_name, nil];
