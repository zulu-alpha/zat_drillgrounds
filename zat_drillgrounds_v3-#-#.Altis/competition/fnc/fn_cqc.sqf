params ["_participant"];

cqc_course setVariable ["course_isActive", true, true];
cqc_course setVariable ["course_enemy_kia", 0, true];
cqc_course setVariable ["course_civ_kia", 0, true];
cqc_course setVariable ["course_participant", _participant, true];
cqc_shoothouse_1 setVariable ["shoothouse_settings_target", [true, 0.5, 1], true];
_participant setVariable ["paintball_hits", 0, true];

// Track enemy
_this spawn {
	params ["_participant"];
	while {sleep 1; cqc_course getVariable ["course_isActive", false]} do {
		{
			if !(_x getVariable ["course_isTracked", false]) then {
				_x addMPEventHandler ["MPKilled", {
					private _e_alive = {alive _x} count (list cqc_trg_enemy);
					private _score = cqc_course getVariable ["course_enemy_kia", 0];
						_score = _score + 1;
					cqc_course setVariable ["course_enemy_kia", _score, true];
					if (_e_alive > 1) then {
						[
							format ["+1 EKIA! Remaining: %1", _e_alive]
						] remoteExec [
							"paintball_fnc_hint",
							cqc_course getVariable [
								"course_participant",
								ObjNull
							]
						];
					};
				}];
				_x setVariable ["course_isTracked", true, true];
			};
		} forEach (list cqc_trg_enemy)
	};
};

// Track Civs
_this spawn {
	params ["_participant"];
	while {sleep 1; cqc_course getVariable ["course_isActive", false]} do {
		{
			if !(_x getVariable ["course_isTracked", false]) then {
				_x addMPEventHandler ["MPKilled", {
					private _score = cqc_course getVariable ["course_civ_kia", 0];
						_score = _score + 1;
					cqc_course setVariable ["course_civ_kia", _score, true];
					[
						format ["+1 Civilian KIA! Killed so far: %1", _score]
					] remoteExec [
						"paintball_fnc_hint",
						cqc_course getVariable [
							"course_participant",
							ObjNull
						]
					];
				}];
				_x setVariable ["course_isTracked", true, true];
			};
		} forEach (list cqc_trg_civ)
	};
};

// Actual course
_this spawn {

	params ["_participant"];
	cqc_course setVariable ["course_startTime", time, true];

	// Setup
	{
		[_x, "close"] remoteExec ["shootHouse_fnc_requestOperateDoors", 2];
	} forEach [cqc_shoothouse_1];
	sleep 2;

	// Stage 1 Move
	cqc_junk = [
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[(getPosASL cqc_pointer_1) select 0, (getPosASL cqc_pointer_1) select 1, ((getPosASL cqc_pointer_1) select 2) + 3],
			false
		]
	];
	["The course has started! Move to position 1!"] remoteExec ["paintball_fnc_hint", _participant];

	// Stage 1 
	waitUntil {_participant in (list cqc_trg_pos_1) or !(cqc_course getVariable ["course_isActive", false])};
	if !(cqc_course getVariable ["course_isActive", false]) exitWith {};
	{deleteVehicle _x} forEach cqc_junk;
    [cqc_shoothouse_1, _participant] remoteExec ["shootHouse_fnc_requestSpawnGroups", 2];
	sleep 3;  // So stage end trigger doesn't trigger prematurely

	// Stage 1 finish
	waitUntil {({alive _x} count (list cqc_trg_enemy) == 0) or !(cqc_course getVariable ["course_isActive", false])};
	if !(cqc_course getVariable ["course_isActive", false]) exitWith {};
	
	// Finish
	cqc_junk = [];
	[_participant, false] remoteExec ["competition_fnc_cqcCleanup", 2];

};
