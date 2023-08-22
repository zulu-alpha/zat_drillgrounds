/*

    Author: Phoenix of Zulu-Alpha

    Description: Monitoring loop that adds killed event handler for civilians or enemies
	             tracked by the relevant trigger and notifies players of their deaths.

    Params:
        0: OBJECT - Root course object
		1: BOOL - Is this for enemeis (otherwise civilians)?

    Returns: None

*/

if !(isServer) exitWith {};

_this spawn {

	params ["_logicRoot", "_isForEnemy"];
	private _role = if (_isForEnemy) then {
		competition_var_name_TriggerEnemy
	} else {
		competition_var_name_TriggerCiv
	};
	private _trigger = _logicRoot getVariable (format ["competition_trigger_%1", _role]);
	[format [
		"Running killed EH loop using trigger %1 and root logic %2",
		_trigger,
		_logicRoot
	]] call competition_fnc_log;

	while {sleep 1; _logicRoot getVariable ["competition_isActive", false]} do {
		{
			if !(_x getVariable ["competition_isTracked", false]) then {
				_x setVariable ["competition_logicRoot", _logicRoot, true];
				_x setVariable ["competition_isForEnemy", _isForEnemy, true];
				_x setVariable ["competition_detectingTrigger", _trigger, true];
				[format ["%1 is tracking %2", _trigger, _x]] call competition_fnc_log;
				_x addMPEventHandler [
					"MPKilled",
					{
						params ["_unit", "_killer", "_instigator", "_useEffects"];
						if !(isServer) exitWith {};
						if (_unit getVariable ["competition_isCounted", false]) exitWith {};
						private _logicRoot = _unit getVariable "competition_logicRoot";
						private _isForEnemy = _unit getVariable "competition_isForEnemy";
						private _trigger = _unit getVariable "competition_detectingTrigger";
						private _role = if (_isForEnemy) then {"enemy"} else {"civilian"};
						private _counterName = format ["competition_%1KIA", _role];
						private _score = _logicRoot getVariable [_counterName, 0];
						_score = _score + 1;
						private _participants = _logicRoot getVariable [
							"competition_participants", []
						];
						if (_isForEnemy) then {
							{
								[
									format [
										"+1 Enemy KIA! Remaining: %1",
										{alive _x} count (list _trigger)
									]
								] remoteExec ["competition_fnc_hint", _x];
							} forEach _participants;
						} else {
							{
								[
									format ["+1 Civilian KIA! Killed so far: %1", _score]
								] remoteExec ["competition_fnc_hint", _x];
							} forEach _participants;
						};
						_logicRoot setVariable [_counterName, _score, true];
						_unit setVariable ["competition_isCounted", true];
					}
				];
				_x setVariable ["competition_isTracked", true, true];
			};
		} forEach (list _trigger)
	};

};
