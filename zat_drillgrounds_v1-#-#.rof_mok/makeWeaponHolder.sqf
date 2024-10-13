/*
	Description:
	Makes a weapon holder at the given objects location with the specified kit and amount.

	Example:
		nul = [this, [["SMG_01_F", 2]], [["7Rnd_408_Mag", 1], ["ACE_M84", 5]], [["ItemMap", 1]]] execVM "makeWeaponHolder.sqf";

	Parameter(s):
	0: OBJECT - Object to use as reference location.
	1: ARRAY - Array of array of strings and integers representing weapon classnames to add and their amounts.
	2: ARRAY - Array of array of strings and integers representing magazine classnames to add and their amounts.
	3: ARRAY - Array of array of strings and integers representing item classnames to add and their amounts.

	Returns:
	Nothing
*/
if !(isServer) exitWith {};

params ["_ref", "_weapons", "_magazines", "_items"];

_holder = "GroundWeaponHolder_Scripted" createVehicle [0,0,0];
_holder setPosATL (getPosATL _ref);
_holder setDir (getDir _ref);
{
	_holder addWeaponCargoGlobal _x
} forEach _weapons;
{
	_holder addMagazineCargoGlobal _x
} forEach _magazines;
{
	_holder addItemCargoGlobal _x
} forEach _items;