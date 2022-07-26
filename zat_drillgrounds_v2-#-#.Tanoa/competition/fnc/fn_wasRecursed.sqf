/*

    Author: Phoenix of Zulu-Alpha

    Description: Checks if the given game logic has been recursed before.

    Params:
		0: OBJECT - Root game logic that the course is based on.	
        1: OBJECT - game logic to check

    Returns: BOOL - true if it was already recursed.

*/

params ["_logicRoot", "_logicCurr"];

private _recursedLogics = _logicRoot getVariable "competition_recursedLogics";
if (_logicCurr in _recursedLogics) exitWith {
	[format ["Already recursed %1", _logicCurr]] call competition_fnc_log;
	true
};
false