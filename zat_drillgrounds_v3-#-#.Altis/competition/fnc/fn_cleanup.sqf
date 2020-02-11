/*

    Author: Phoenix of Zulu-Alpha

    Description: Resets the course and can be executed during (for cancellations) or
	after (for completions) the course.

    Params:
        0: OBJECT - Root course object.
		1: CODE - Tear down code.
		2: ARRAY - Of OBJECTs to delete.
		3: ARRAY - Of players to notify.
		4: BOOL - True if the course was aborted.

    Returns: None

*/

params ["_logicRoot", "_stage", "_stageNumber", "_participants", "_codeTeardown", "_junk", "_isAborted"];

[] call _codeTeardown;
_logicRoot setVariable ["competition_currStage", objNull, true];
{deleteVehicle _x} forEach _junk;
{	
	private _ehIndex = _x getVariable ["competition_firedManEHIndex", -1];
	if (_ehIndex > -1) then {
		_x removeEventHandler ["FiredMan", _ehIndex];
		_x setVariable ["competition_firedManEHIndex", nil];
	};
} forEach _participants;
_logicRoot setVariable ["competition_isActive", false, true];