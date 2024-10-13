/*

    Author: Phoenix of Zulu-Alpha

    Description: Recurse through the range objects to process other game logics and
			     triggers and build the course.

    Params:
        0: OBJECT - Root game logic that the course is based on.
		1: OBJECT - Current game logic to recurse.

    Returns: None

*/

params ["_logicRoot", "_logicCurr"];

private _recursedLogics = _logicRoot getVariable "competition_recursedLogics";
if (_logicCurr in _recursedLogics) exitWith {
	[format ["Already recursed %1", _logicCurr]] call competition_fnc_log;
};
_recursedLogics pushBack _logicCurr;
_logicRoot setVariable ["competition_recursedLogics", _recursedLogics, false];

{
	if !(typeName (_logicCurr getVariable [_x, objNull]) == typeName {}) then {
		throw (format [
			"%1 stage logic needs a variable %2 that is valid code.",
			_logicCurr,
			_x
		]);
	};
} forEach [competition_var_name_setup, competition_var_name_teardown];
private _numSynced = count synchronizedObjects _logicCurr;
if (_numSynced < 3 or _numSynced > 4) then {
	throw (format [
		"%1 stage logic needs 2 trigger labelling game logics (start and finish), and 1 or 2 other game logics (2 stages, 1 stage and the course root logic, or the previous stage if the last stage) synced to it.",
		_logicCurr
	]);
};
[format ["%1 is valid stage", _x]] call competition_fnc_log;

private _stages = _logicRoot getVariable "competition_stages";
_stages pushBackUnique _logicCurr;
_logicRoot setVariable ["competition_stages", _stages, false];

[format ["Starting recurse for %1", _logicCurr]] call competition_fnc_log;
{

	[format ["Checking %1", _x]] call competition_fnc_log;

	if (_x isKindOf competition_var_classes_gameLogic) then {
		[format ["%1 is game logic", _x]] call competition_fnc_log;

		private _isLabel = [
			_x,
			_logicCurr,
			[competition_var_name_TriggerStart, competition_var_name_TriggerFinish]
		] call competition_fnc_setLabelledTrigger;
		
		if !(_isLabel) then {
			[format ["%1 is stage", _x]] call competition_fnc_log;
			[_logicRoot, _x] call competition_fnc_recurseCourse;
		};

	};

} forEach synchronizedObjects _logicCurr;