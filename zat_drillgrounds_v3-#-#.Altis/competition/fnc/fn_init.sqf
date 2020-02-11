/*

    Author: Phoenix of Zulu-Alpha

    Description: Initializes the processing of the competition range.
	             Recursively processes synced objects as well.

    Params:
        0: OBJECT - Game logc
		1: STRING - Name of the course

    Returns: None

*/

if !(isServer) exitWith {};
_this spawn {
	
	params ["_logicRoot", "_courseName"];

	waitUntil {time > 1};

	[format ["Started init for %1", _logicRoot]] call competition_fnc_log;
	_logicRoot setVariable ["competition_name", _courseName, true];

	if ((count synchronizedObjects _logicRoot) < 4) then {
		throw "The course root logic needs 2 trigger labelling game logics (enemy and civ), an interface and the first stage synced to it.";
	};

	_logicRoot setVariable ["competition_recursedLogics", [_logicRoot], false];
	_logicRoot setVariable ["competition_stages", [], false];

	{

		[format ["Checking %1", _x]] call competition_fnc_log;

		if ((typeOf _x) in competition_var_classes_interfaces) then {
			[format ["%1 is an intervace console", _x]] call competition_fnc_log;
			[_logicRoot, _x] remoteExec ["competition_fnc_addMenuOptions", 0, true];
		};

		if (_x isKindOf competition_var_classes_gameLogic) then {
			[format ["%1 is game logic", _x]] call competition_fnc_log;

			private _isLabel = [
				_x,
				_logicRoot,
				[competition_var_name_TriggerEnemy, competition_var_name_TriggerCiv]
			] call competition_fnc_setLabelledTrigger;

			if !(_isLabel) then {
				[format ["%1 is stage", _x]] call competition_fnc_log;
				[_logicRoot, _x] call competition_fnc_recurseCourse;
			}

		};

	} forEach (synchronizedObjects _logicRoot);

	{
		private _trigger = _logicRoot getVariable [
			format ["competition_trigger_%1", _x], objNull
		];
		if (isNull _trigger) then {
			throw (format [
				"The course root logic needs a/an %1 trigger.",
				_x
			]);
		};
	} forEach [competition_var_name_TriggerEnemy, competition_var_name_TriggerCiv];

	[format ["Finished init for %1", _logicRoot]] call competition_fnc_log;
};
