/*

    Author: Phoenix of Zulu-Alpha

    Description: Deletes the circle for the given group target combination from 
                 Knowledge_circleJobs namespace.

    Params:
		0: STRING - Variable name for circle objects in the given namespace.
    2: OBJECT - Object containing namespace for circles

    Returns: None

*/
params ["_var_name", "_circles_namespace"];

{
	deleteVehicle _x;
} forEach (_circles_namespace getVariable [_var_name, []]);

_circles_namespace setVariable [_var_name, nil];
