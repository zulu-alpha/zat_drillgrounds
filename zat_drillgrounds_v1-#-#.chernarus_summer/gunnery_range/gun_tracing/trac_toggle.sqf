/*
	Author: Phoenix of Zulu-alpha

	License: APL-SA

	Description:
		Enables or disables Hypnomatic's Trace script

	Parameters:
		3: 0: (BOOL) - Wether to enable or disable the trace script

	Returns:
		Nothing
*/

_action = (_this select 3) select 0;
_lifetime = 15;


// If must enable (true)
if (_action) then {
	[player, nil, _lifetime, nil, nil, nil, true] call hyp_fnc_traceFire;
	zam_gun_var_isTrace = True;

// If must disable (false)
} else {
	[player] call hyp_fnc_traceFireRemove;
	zam_gun_var_isTrace = False;
};