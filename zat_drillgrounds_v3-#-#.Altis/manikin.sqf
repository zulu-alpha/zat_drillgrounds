/*
	Author: Phoenix

	Description: Adds addaction menu options for spawning or deleting a manikin on the given object (such as a mat)

	Params:
	  0: OBJECT - The object that stores information and has the addaction options.
	  1: OBJECT - The object the manikin spawns on top of. 
	  2: STRING - The config name of the man to spawn (decides side).

	Usage: nul = [this, this, "O_G_Soldier_unarmed_F"] execVM "manikin.sqf";

	Reference:
		damageTypes: bullet, grenade, explosive, shell, vehiclecrash, collision,
		backblast, stab, punch, falling, ropeburn, drowning, unknown

		Body parts: Head, Body, LeftArm, RightArm, LeftLeg, RightLeg

*/

if !(hasInterface) exitWith {};
waitUntil {(time > 1) and {!(isNull player)}};

params ["_controller", "_mat", "_model"];


private _manikin_create = {

	/*
		For spawning a dummy AI suitable for medical training. Add to object to spawn manikin on
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_mat", "_model"];
	private _pos = getPosATL _mat;

	if !(isNull (_target getVariable ["med_dummy", ObjNull])) exitWith {
		hint "Manikin already spawned!";
	};

	private _manikin_group = createGroup east;
	private _manikin = _manikin_group createUnit [_model, _pos, [], 0, "NONE"];
	_manikin_group deleteGroupWhenEmpty true;
	_manikin setVariable ["acex_headless_blacklist", true, true];
	removeAllWeapons _manikin;
	removeAllItems _manikin;
	removeAllAssignedItems _manikin;
	removeUniform _manikin;
	removeVest _manikin;
	removeBackpack _manikin;
	removeHeadgear _manikin;
	removeGoggles _manikin;
	_manikin setPosATL _pos;
	_manikin setDir (getDir _mat);

	{
		_manikin disableAI _x;
	} forEach [
		"TARGET", "AUTOTARGET", "MOVE", "TEAMSWITCH", "FSM", "AIMINGERROR", "SUPPRESSION",
		"CHECKVISIBLE", "COVER", "AUTOCOMBAT", "PATH"
	];

	_target setVariable ['med_dummy', _manikin, true];

	while {sleep 0.1; alive _manikin} do {

		private _heart_rate = _manikin getVariable ["ace_medical_heartrate", 80];
			private _heart_rate_simple = "None";
			if (_heart_rate > 1) then {
				_heart_rate_simple = "Weak";
				if (_heart_rate > 60) then {
					if (_heart_rate > 100) then {
						_heart_rate_simple = "Strong";
					} else {
						_heart_rate_simple = "Normal";
					};
				};
			};
			([_manikin] call ace_medical_status_fnc_getBloodPressure) params ["_blood_pressure_low", "_blood_pressure_high"];
			private _blood_pressure_simple = "None";
			if (_blood_pressure_high > 20) then {
				if (_blood_pressure_high > 20) then {
					_blood_pressure_simple = "Low";
					if (_blood_pressure_high > 100) then {
						_blood_pressure_simple = "Normal";
						if (_blood_pressure_high > 160) then {
							_blood_pressure_simple = "High";
						};
					};
				};
			};

		_manikin setVariable [
			"manikin_vitals",
			[
				[_manikin] call ace_medical_status_fnc_hasStableVitals,
				_manikin getVariable ["ace_isunconscious", false],
				_heart_rate,
				_heart_rate_simple,
				_blood_pressure_high,
				_blood_pressure_low,
				_blood_pressure_simple,
				_manikin getVariable ["ace_medical_bloodvolume", 6.0],
				[_manikin] call ace_medical_status_fnc_getBloodLoss,
				[_manikin] call ace_medical_status_fnc_getCardiacOutput,
				_manikin getVariable ["ace_medical_inCardiacArrest", false],
				_manikin getVariable ["ace_medical_statemachine_cardiacArrestTimeLeft", -1],
				[_manikin, "Morphine", false] call ace_medical_status_fnc_getMedicationCount,
				[_manikin, "Epinephrine", false] call ace_medical_status_fnc_getMedicationCount,
				[_manikin, "Adenosine", false] call ace_medical_status_fnc_getMedicationCount
			],
			true
		];

	};

};

private _manikin_delete = {

	/*
		Delete manakin spawned with med_dummy.sqf
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	private _manikin = _target getVariable ["med_dummy", ObjNull];

	if (isNull _manikin) exitWith {
		hint "No manikin spawned!"
	};

	deleteVehicle _manikin;

};

private _manikin_add_random_wound = {

	/*
		Add random wound to manikin
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	private _manikin = _target getVariable ["med_dummy", ObjNull];

	[
		_manikin, 
		(0.5 + random 0.5),
		selectRandom ["Head", "Body", "LeftArm", "RightArm", "LeftLeg", "RightLeg"],
		selectRandom [
			"bullet",
			"grenade",
			"explosive",
			"shell",
			"vehiclecrash",
			"collision",
			"backblast",
			"stab",
			"punch",
			"falling",
			"ropeburn"
		]
	] call ace_medical_fnc_addDamageToUnit;

};

private _manikin_stop_monitor = {

	/*
		Stops the monitoring of the given manikin mat
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];

	_caller setVariable ["manikin_monitoringMat", objNull, false];
	hintSilent "";

};

private _manikin_start_monitor = {

	/*
		Start monitoring the given manikin mat
	*/

	params ["_target", "_caller", "_actionId", "_arguments"];
	
	private _hint_str = "<t align='center'>
		Has stable vitals (can wake up): <t color='#ffff00'>%2</t>
		<br/>Is concious: <t color='#ffff00'>%3</t>
		<br/>Heart rate: <t color='#ffff00'>%4</t>
		<br/>Blood pressure: <t color='#ffff00'>%5</t>
		<br/>
		<br/>Blood volume: <t color='#ffff00'>%6 L</t>
		<br/>Blood loss rate: <t color='#ffff00'>%7 L/min</t>
		<br/>Cardiac (Heart) output: <t color='#ffff00'>%8 L/min</t>
		<br/>1/4 Cardiac output: <t color='#ffff00'>%9 L/min</t>
		<br/>In Cardiac arrest: <t color='#ffff00'>%10</t>
		<br/>Cardiac arrest time left: <t color='#ffff00'>%11s</t>
		<br/>
		<br/>Effective morphine shots: <t color='#ffff00'>%12</t>
		<br/>Effective epinephrine shots: <t color='#ffff00'>%13</t>
		<br/>Effective adenosine shots: <t color='#ffff00'>%14</t>
		";

	_caller setVariable ["manikin_monitoringMat", _target, false];
	while {(_caller getVariable ["manikin_monitoringMat", objNull]) == _target} do {		

		private _manikin = _target getVariable ["med_dummy", ObjNull];
		private _vitals = _manikin getVariable ["manikin_vitals", []];
		if (count _vitals == 0) then {
			hintSilent "Error: No manikin data";
		} else {
			_vitals params [
				"_hasStableVitals",
				"_isUnconcious",
				"_heartRate",
				"_heartRateSimple",
				"_bpHigh",
				"_bpLow",
				"_bpSimple",
				"_bloodVolume",
				"_bloodLoss",
				"_cardiacOutput",
				"_inCardiacArrest",
				"_cardiacArrestTimeLeft",
				"_effectiveMorphine",
				"_effectiveEpinephrine",
				"_effectiveAdenosine"
			];
			hintSilent parseText format [
				_hint_str,
				"%",
				_hasStableVitals,
				!(_isUnconcious),
				format ["%1 b/min (%2)", _heartRate, _heartRateSimple],
				format ["%1/%2 mmHg (%3)", _bpHigh, _bpLow, _bpSimple],
				_bloodVolume,
				_bloodLoss * 60,
				_cardiacOutput * 60,
				_cardiacOutput * 15,
				_inCardiacArrest,
				round _cardiacArrestTimeLeft,
				_effectiveMorphine,
				_effectiveEpinephrine,
				_effectiveAdenosine
			];
		};

		sleep 0.1;
	};

};

_controller addaction ["Spawn manikin", _manikin_create, [_mat, _model], 1.5, true, true, "", "isNull (_target getVariable ['med_dummy', ObjNull])"];
_controller addaction ["Delete manikin", _manikin_delete, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull]))"];
_controller addaction ["Add random wound", _manikin_add_random_wound, nil , 1.5, true, true, "", "!(isNull (_target getVariable ['med_dummy', ObjNull])) and {local (_target getVariable ['med_dummy', ObjNull])}"];
_controller addaction ["Monitor mat's manikins", _manikin_start_monitor, nil, 1.5, true, true, "", "(_this getVariable ['manikin_monitoringMat', objNull]) != _target"];
_controller addaction ["Stop monitoring any mat", _manikin_stop_monitor, nil, 1.5, true, true, "", "(_this getVariable ['manikin_monitoringMat', objNull]) != objNull"];
