params ["_participant"];

range_course setVariable ["course_isActive", true, true];
range_course setVariable ["course_enemy_kia", 0, true];
range_course setVariable ["course_civ_kia", 0, true];
range_course setVariable ["course_participant", _participant, true];
range_shoothouse_1 setVariable ["shoothouse_settings_target", [true, 0.5, 1], true];
range_shoothouse_2 setVariable ["shoothouse_settings_target", [true, 0.5, 1], true];
range_shoothouse_3 setVariable ["shoothouse_settings_target", [true, 0.5, 1], true];
range_shoothouse_4 setVariable ["shoothouse_settings_target", [true, 0.5, 1], true];
range_shoothouse_5 setVariable ["shoothouse_settings_target", [true, 0.5, 1], true];
range_shoothouse_6 setVariable ["shoothouse_settings_target", [true, 0.5, 1], true];
_participant setVariable ["paintball_hits", 0, true];

// Track enemy
_this spawn {
	params ["_participant"];
	while {sleep 1; range_course getVariable ["course_isActive", false]} do {
		{
			if !(_x getVariable ["course_isTracked", false]) then {
				_x addMPEventHandler ["MPKilled", {
					private _e_alive = {alive _x} count (list range_trg_enemy);
					private _score = range_course getVariable ["course_enemy_kia", 0];
						_score = _score + 1;
					range_course setVariable ["course_enemy_kia", _score, true];
					if (_e_alive > 1) then {
						[
							format ["+1 EKIA! Remaining: %1", _e_alive]
						] remoteExec [
							"paintball_fnc_hint",
							range_course getVariable [
								"course_participant",
								ObjNull
							]
						];
					};
				}];
				_x setVariable ["course_isTracked", true, true];
			};
		} forEach (list range_trg_enemy)
	};
};

// Track Civs
_this spawn {
	params ["_participant"];
	while {sleep 1; range_course getVariable ["course_isActive", false]} do {
		{
			if !(_x getVariable ["course_isTracked", false]) then {
				_x addMPEventHandler ["MPKilled", {
					private _score = range_course getVariable ["course_civ_kia", 0];
						_score = _score + 1;
					range_course setVariable ["course_civ_kia", _score, true];
					[
						format ["+1 Civilian KIA! Killed so far: %1", _score]
					] remoteExec [
						"paintball_fnc_hint",
						range_course getVariable [
							"course_participant",
							ObjNull
						]
					];
				}];
				_x setVariable ["course_isTracked", true, true];
			};
		} forEach (list range_trg_civ)
	};
};

// Actual course
_this spawn {

	params ["_participant"];
	range_course setVariable ["course_startTime", time, true];

	// Stage 1 Move
	range_junk = [
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[(getPosASL range_pointer_1) select 0, (getPosASL range_pointer_1) select 1, ((getPosASL range_pointer_1) select 2) + 3],
			false
		]
	];
	["The course has started! Move to position 1!"] remoteExec ["paintball_fnc_hint", _participant];

	// Stage 1 
	waitUntil {_participant in (list range_trg_pos_1) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};
	{deleteVehicle _x} forEach range_junk;
    [range_shoothouse_1, _participant] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];
	sleep 3;  // So stage end trigger doesn't trigger prematurely

	// Stage 1 finish
	waitUntil {({alive _x} count (list range_trg_enemy) == 0) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};

	// Stage 2 Move
	range_junk = [
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[(getPosASL range_pointer_2) select 0, (getPosASL range_pointer_2) select 1, ((getPosASL range_pointer_2) select 2) + 3],
			false
		]
	];
	["Stage 1 completed! Move to position 2!"] remoteExec ["paintball_fnc_hint", _participant];

	// Stage 2
	waitUntil {_participant in (list range_trg_pos_2) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};
	{deleteVehicle _x} forEach range_junk;
	[range_shoothouse_2, _participant] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];
	sleep 3;  // So stage end trigger doesn't trigger prematurely

	// Stage 2 finish
	waitUntil {({alive _x} count (list range_trg_enemy) == 0) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};

	// Stage 3 Move
	range_junk = [
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[(getPosASL range_pointer_3) select 0, (getPosASL range_pointer_3) select 1, ((getPosASL range_pointer_3) select 2) + 3],
			false
		]
	];
	["Stage 2 completed! Move to position 3!"] remoteExec ["paintball_fnc_hint", _participant];

	// Stage 3
	waitUntil {_participant in (list range_trg_pos_3) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};
	{deleteVehicle _x} forEach range_junk;
	[range_shoothouse_3, _participant] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];
	sleep 3;  // So stage end trigger doesn't trigger prematurely

	// Stage 3 finish
	waitUntil {({alive _x} count (list range_trg_enemy) == 0) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};

	// Stage 4 Move
	range_junk = [
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[(getPosASL range_pointer_4) select 0, (getPosASL range_pointer_4) select 1, ((getPosASL range_pointer_4) select 2) + 3],
			false
		]
	];
	["Stage 3 completed! Move to position 4!"] remoteExec ["paintball_fnc_hint", _participant];

	// Stage 4
	waitUntil {_participant in (list range_trg_pos_4) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};
	{deleteVehicle _x} forEach range_junk;
	[range_shoothouse_4, _participant] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];
	sleep 3;  // So stage end trigger doesn't trigger prematurely

	// Stage 4 finish
	waitUntil {({alive _x} count (list range_trg_enemy) == 0) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};

	// Stage 5 Move
	range_junk = [
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[(getPosASL range_pointer_5) select 0, (getPosASL range_pointer_5) select 1, ((getPosASL range_pointer_5) select 2) + 3],
			false
		]
	];
	["Stage 4 completed! Move to position 5!"] remoteExec ["paintball_fnc_hint", _participant];

	// Stage 5
	waitUntil {_participant in (list range_trg_pos_5) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};
	{deleteVehicle _x} forEach range_junk;
	[range_shoothouse_5, _participant] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];
	sleep 3;  // So stage end trigger doesn't trigger prematurely

	// Stage 5 finish
	waitUntil {({alive _x} count (list range_trg_enemy) == 0) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};

	// Stage 6 Move
	range_junk = [
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[(getPosASL range_pointer_6) select 0, (getPosASL range_pointer_6) select 1, ((getPosASL range_pointer_6) select 2) + 3],
			false
		]
	];
	["Stage 5 completed! Move to position 6!"] remoteExec ["paintball_fnc_hint", _participant];

	// Stage 6
	waitUntil {_participant in (list range_trg_pos_6) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};
	{deleteVehicle _x} forEach range_junk;
	[range_shoothouse_6, _participant] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];
	sleep 3;  // So stage end trigger doesn't trigger prematurely

	// Stage 6 finish
	waitUntil {({alive _x} count (list range_trg_enemy) == 0) or !(range_course getVariable ["course_isActive", false])};
	if !(range_course getVariable ["course_isActive", false]) exitWith {};
	
	// Finish
	range_junk = [];
	[_participant, false] remoteExec ["competition_fnc_rangeCleanup", 2];

};
