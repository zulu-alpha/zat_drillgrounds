/*
	Author: Phoenix

	Description: Adds Manikin's at various ranges at bearings to experiment with explosives.
	The script will automatically determine the bearing and ranges of manikin spawns.

	Params:
	  0: OBJECT - The object that stores information and has the addaction options.
	  1: OBJECT - Reference object the manikins spawns relative to. 
	  2: STRING - The config name of the man to spawn (decides side).
	  3: NUMBER - Number of manikin's to spawn
	  4: NUMBER - Starting distance to spawn from reference object
	  5: NUMBER - Interval distance to spawn from reference object.
	  6: NUMBER - Sector in degrees to spwan, with the center of the sector in the relative
	              object heading.

	Usage: nul = [this, this, "O_G_Soldier_unarmed_F", 10, 10, 10, 180] execVM "area_manikins.sqf";
*/

params [
	"_controller", "_reference", "_model", "_num_manikins",
	"_start_dist", "_interval_dist", "_sector"
];

private _manikin_create_all = {

	/*
		Description: For the actual spawning of dummy AIs that does nothing. 
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params [
		"_reference", "_model", "_num_manikins", "_start_dist", "_interval_dist", "_sector"
	];

	if (count (_target getVariable ["manikins", []]) > 0) exitWith {
		hint "Manikins already spawned!";
	};

	_starting_angle = - (_sector / 2);
	_angle_increment = _sector / (_num_manikins - 1);  // -1 due to starting at 0
	private _manikin_group = createGroup east;
	_manikin_group deleteGroupWhenEmpty true;
	diag_log format ["For Spawning, using _angle_increment %1", _angle_increment];

	for "multipier" from 0 to (_num_manikins - 1) do
	{
		private _dist = _start_dist + (multipier * _interval_dist);
		private _bearing = _starting_angle + (multipier * _angle_increment);
		private _pos = _reference getRelPos [_dist, _bearing];
		diag_log format ["Spawning at %1 degrees and %2 meters", _bearing, _dist];
		[_target, _reference, _model, _manikin_group, _pos] call fnc_manikin_create;
	};

};

fnc_manikin_create = {

	/*
		Description: For the actual spawning of dummy AIs that does nothing and faces ref. 
	*/
	params ["_controller", "_reference", "_model", "_manikin_group", "_pos"];

	private _manikin = _manikin_group createUnit [_model, _pos, [], 0, "NONE"];

	removeAllWeapons _manikin;
	removeAllItems _manikin;
	removeAllAssignedItems _manikin;
	removeUniform _manikin;
	removeVest _manikin;
	removeBackpack _manikin;
	removeHeadgear _manikin;
	removeGoggles _manikin;
	(group _manikin) setVariable ["Vcm_Disable",true];

	{
		_manikin disableAI _x;
	} forEach [
		"TARGET",
		"AUTOTARGET",
		"MOVE",
		"ANIM",
		"TEAMSWITCH",
		"FSM",
		"WEAPONAIM",
		"AIMINGERROR",
		"SUPPRESSION",
		"CHECKVISIBLE",
		"COVER",
		"AUTOCOMBAT",
		"PATH",
		"MINEDETECTION",
		"NVG",
		"LIGHTS",
		"RADIOPROTOCOL"
	];

	_manikin setPosATL _pos;
	_manikin setDir (getDir _manikin + (_manikin getRelDir _reference));

	_manikins = _controller getVariable ["manikins", []];
	_manikins pushBackUnique _manikin;
	_controller setVariable ["manikins", _manikins, true];

};

private _manikin_delete = {

	/*
		Description: Delete manakins spawned
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	_manikins = _target getVariable ["manikins", []];

	if (count (_target getVariable ['manikins', []]) == 0) exitWith {
		hint "No manikins spawned!"
	};

	{
		if !(isNull _x) then {
			deleteVehicle _x;
		};
	} forEach _manikins;
	_target setVariable ["manikins", [], true];

};


_controller addaction ["Spawn manikins", _manikin_create_all, [_reference, _model, _num_manikins, _start_dist, _interval_dist, _sector], 1.5, true, true, "", "count (_target getVariable ['manikins', []]) == 0"];
_controller addaction ["Delete manikins", _manikin_delete, nil , 1.5, true, true, "", "count (_target getVariable ['manikins', []]) > 0"];
