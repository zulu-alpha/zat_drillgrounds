params ["_cone", "_type", "_pos", "_direction"];

knowledge_fnc_spawnTarget = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	_arguments params ["_type", "_pos", "_direction"];
	private _target = (createGroup east) createUnit [_type, _pos, [], 0, "NONE"];
	_target setDir _direction;
	_target disableAI "MOVE";
	_target disableAI "FSM";
	_cone setVariable ["target", _target, true];
	knowledge_monitoring = true;
	_target setSkill 1;
	[_cone] execVM "knowledge\loop.sqf";
};

knowledge_fnc_deleteTarget = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	private _target = _cone getVariable ["target", objNull];
	private _group = group _target;
	deleteVehicle _target;
	deleteGroup _group;
	private _target = _cone setVariable ["target", objNull, true];
	knowledge_monitoring = false;
	hint "";
};

knowledge_fnc_startMonitor = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	knowledge_monitoring = true;
	[_cone] execVM "knowledge\loop.sqf";
};

knowledge_fnc_stopMonitor = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	knowledge_monitoring = false;
	hint "";
};

if (isNil "knowledge_monitoring") then {
	knowledge_monitoring = false;
};

_cone addAction ["<t color=""#ff0000"">" + ("Spawn target") + "</t>", knowledge_fnc_spawnTarget, [_type, _pos, _direction], 1.5, true, true, "", "!(knowledge_monitoring) and isNull (_target getVariable ['target', objNull])"];
_cone addAction ["<t color=""#ff0000"">" + ("Delete target") + "</t>", knowledge_fnc_deleteTarget, nil, 1.5, true, true, "", "!(isNull (_target getVariable ['target', objNull]))"];
_cone addAction ["<t color=""#ff0000"">" + ("Start monitoring this cone's target") + "</t>", knowledge_fnc_startMonitor, nil, 1.5, true, true, "", "!(knowledge_monitoring) and !(isNull (_target getVariable ['target', objNull]))"];
_cone addAction ["<t color=""#ff0000"">" + ("Stop monitoring all targets") + "</t>", knowledge_fnc_stopMonitor, nil, 1.5, true, true, "", "knowledge_monitoring"];
