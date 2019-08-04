params ["_cone", "_type"];

gunsound_distances = [50, 100, 200, 300, 400, 500];
gunsound_directions = [0, 45, 90, 135, 180, 225, 270, 315];
gunsound_types = ["CUP_B_CDF_Soldier_DST", "CUP_B_US_Soldier"];

gunsound_fnc_randomPos = {
	params ["_cone"];
	private _distance = gunsound_distances call BIS_fnc_selectRandom;
	private _direction = gunsound_directions call BIS_fnc_selectRandom;
	_cone setVariable ["distance", _distance];
	_cone setVariable ["direction", _direction];
    [getPosATL _cone, _distance, _direction] call BIS_fnc_relPos
};

gunsound_fnc_createShooter = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	if !(isNull (_cone getVariable ["shooter", objNull])) exitWith {hint "Already a shooter!"};
	private _pos = [_cone] call gunsound_fnc_randomPos;
	private _type = gunsound_types call BIS_fnc_selectRandom;
	private _shooter = (createGroup west) createUnit [_type, _pos, [], 0, "NONE"];
	_cone setVariable ["shooter", _shooter, true];
	_shooter setDir ([_shooter, _cone] call BIS_fnc_dirTo);
	_shooter setUnitPos "UP";
	_shooter doTarget _cone;
	_shooter disableAI "MOVE";
	_shooter disableAI "FSM";
	_shooter disableAI "AIMINGERROR";
};

gunsound_fnc_deleteShooter = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	private _shooter = _cone getVariable ["shooter", objNull];
	if (isNull _shooter) exitWith {hint "No shooter!"};
	private _group = group _shooter;
	deleteVehicle _shooter;
	deleteGroup group _shooter;
	private _shooter = _cone setVariable ["_shooter", objNull, true];
	_cone setVariable ["distance", objNull, true];
	_cone setVariable ["direction", objNull, true];
	hintSilent "";
};

gunsound_fnc_fire = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	private _shooter = _cone getVariable ["shooter", objNull];
	if (isNull _shooter) exitWith {hint "No shooter!"};
	_shooter forceWeaponFire [primaryWeapon _shooter, "single"];
};

gunsound_fnc_showInfo = {
	params ["_cone", "_caller", "_ID", "_arguments"];
	private _shooter = _cone getVariable ["shooter", objNull];
	if (isNull _shooter) exitWith {hint "No shooter!"};
	hint parseText format [
			"
			<t size='2' align='center'>Shooter</t> <br /> 
			Weapon: <t color='%1'>%2</t> <br /> 
			Direction: <t color='%1'>%3</t> <br /> 
			Distance: <t color='%1'>%4</t> <br /> 
			",
			"#FFFF00",
			getText (configFile >> "CfgWeapons" >> (primaryWeapon _shooter) >> "displayName"),
			_cone getVariable ["direction", objNull],
			_cone getVariable ["distance", objNull]
	];
};


_cone addAction ["<t color=""#ff0000"">" + ("Spawn Shooter") + "</t>", gunsound_fnc_createShooter, nil, 1, true, true, "", "isNull (_target getVariable ['shooter', objNull])"];
_cone addAction ["<t color=""#ff0000"">" + ("Fire Weapon") + "</t>", gunsound_fnc_fire, nil, 1, true, true, "", "!(isNull (_target getVariable ['shooter', objNull]))"];
_cone addAction ["<t color=""#ff0000"">" + ("Show Shooter Info") + "</t>", gunsound_fnc_showInfo, nil, 1, true, true, "", "!(isNull (_target getVariable ['shooter', objNull])) and {local (_target getVariable ['shooter', objNull])}"];
_cone addAction ["<t color=""#ff0000"">" + ("Delete Shooter") + "</t>", gunsound_fnc_deleteShooter, nil, 1, true, true, "", "!(isNull (_target getVariable ['shooter', objNull]))"];
