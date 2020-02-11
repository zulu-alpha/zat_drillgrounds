/*

    Author: Phoenix of Zulu-Alpha

    Description: Checks if the given game logic is a valid trigger label, then assigns
	             the trigger to the correct role to the other given game logic.
				 Note that a valid labeller only has one trigger synced to it.

    Params:
        0: OBJECT - Suspected trigger labeller
		1: OBJECT - Game logic to assign the trigger to
		2: ARRAY - Of strings, that are the acceptable role labels.

    Returns: BOOL - true if it was a valid trigger label.

*/

params ["_labeller", "_controlLogic", "_roles"];

private _role = _labeller getVariable [competition_var_name_TriggerRole, "UNDEFINED"];
[format ["Checking if %1 of role %2 is a valid trigger label", _labeller, _role]] call competition_fnc_log;
if (_role == "UNDEFINED") exitWith {
	[format ["%1 is not a valid trigger label", _labeller, _role]] call competition_fnc_log;
	false
};

if !(_role in _roles) then {
	throw (format [
		"%1 trigger labelling game logic for game logic %2 must have a label that is in %3, but instead has %4.",
		_labeller,
		_controlLogic,
		_roles,
		_role
	]);
};
if !({
		_x isKindOf competition_var_classes_trigger
	} count (synchronizedObjects _labeller) == 1) then {
	throw (format [
		"%1 trigger labelling game logic must have 1 and only 1 trigger synced to it",
		_labeller
	]);
};
[format ["%1 is a valid trigger labeler", _labeller]] call competition_fnc_log;

{
	if (_x isKindOf competition_var_classes_trigger) then {
		_controlLogic setVariable [
			format ["competition_trigger_%1", _role],
			_x,
			false
		];
		[format [
			"%1 is a trigger with role %2 for %3",
			_x,
			_role,
			_controlLogic
		]] call competition_fnc_log;
	};
} forEach synchronizedObjects _labeller;

true