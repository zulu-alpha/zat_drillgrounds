/*

    Author: Phoenix of Zulu-Alpha

    Description: Adds a fired event handler for tracking weapons used.

    Params:
        0: OBJECT - Participant to track weapons for.

    Returns: NUMBER - Event Handler Index

*/

params ["_unit"];

_unit addEventHandler ["FiredMan", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
	private _logicRoot = _unit getVariable "competition_logicRoot";
	private _weaponsUsed = _logicRoot getVariable ["competition_weaponsUsed", []];
	private _weapon = getText (
		configFile >> 
		"CfgWeapons" >> 
		_weapon >> 
		"displayName"
	);
	private _magazine = getText (
		configFile >> 
		"CfgMagazines" >> 
		_magazine >> 
		"displayName"
	);
	_weaponMagString = format ["%1 from %2", _magazine, _weapon];
	_logicRoot setVariable ["competition_weaponsUsed", _weaponMagString];
}]