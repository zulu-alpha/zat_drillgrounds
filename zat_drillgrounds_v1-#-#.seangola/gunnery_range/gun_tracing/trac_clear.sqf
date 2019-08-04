/*
	Author: Phoenix of Zulu-alpha (Hypnomatic's code)

	License: APL-SA

	Description:
		Removes local trace lines

	Parameters:
		None

	Returns:
		Nothing
*/

{
	[_x] call hyp_fnc_traceFireClear
} count hyp_var_tracer_tracedUnits;