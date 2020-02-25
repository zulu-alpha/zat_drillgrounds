/*

    Author: Phoenix of Zulu-Alpha

    Description: Execute the course.

    Params:
        0: OBJECT - Root course object

    Returns: None

*/

if !(isServer) exitWith {};

params ["_logicRoot"];
[format ["Starting course %1", _logicRoot]] call competition_fnc_log;

_logicRoot setVariable ["competition_isActive", true, true];
private _participants = _logicRoot getVariable ["competition_participants", []];
if !(count _participants > 0) then {
	throw (format [
		"There are not participants for course %1",
		_logicRoot
	]);
};
private _stages = _logicRoot getVariable "competition_stages";
private _junk = [];
private _timeTotalStart = time;

[_logicRoot, true] call competition_fnc_KilledEHLoop;
private _triggerCiv = _logicRoot getVariable [
	format ["competition_trigger_%1", competition_var_name_TriggerCiv], objNull
];
if !(isNull _triggerCiv) then {
	[_logicRoot, false] call competition_fnc_KilledEHLoop;
};

{
	_x setVariable [
		"competition_firedManEHIndex", 
		[_x] call competition_fnc_addFiredManEH
	];
} forEach _participants;

private _participants_str = "";
{
	_participants_str = _participants_str + format [
		"%1 (%2), ",
		name _x,
		[_x] call ace_common_fnc_getWeight
	];
} forEach _participants;

private _isAborted = false;
private _totalTime = 0;
private _totalScore = 0;
private _announcements = [
	format [
		"Competition announcement: %1participated in %2 and did:",
		_participants_str, 
		_logicRoot getVariable "competition_name"
	]
];

private _rootCodeSetup = _logicRoot getVariable [competition_var_name_setup, {}];
[_logicRoot, _logicRoot, 0, _participants] call _rootCodeSetup;

[format ["Starting loop for course %1 with %2 stages", _logicRoot, count _stages]] call competition_fnc_log;
for "_stageNumber" from 1 to (count _stages) do {

	#define IS_ACTIVE (_logicRoot getVariable ["competition_isActive", false])

	private _stage = _stages select (_stageNumber - 1);
	[format ["Setting up stage %1, %2", _stageNumber, _stage]] call competition_fnc_log;
	_logicRoot setVariable ["competition_currStage", _stage, true];
	private _triggerStart = _stage getVariable [
		format ["competition_trigger_%1", competition_var_name_TriggerStart], objNull
	];
	if (isNull _triggerStart) then {
		throw (format [
			"There is no start trigger for stage %1 of course %2",
			_stage,
			_logicRoot
		]);
	};
	private _triggerFinish = _stage getVariable [
		format ["competition_trigger_%1", competition_var_name_TriggerFinish], objNull
	];
	if (isNull _triggerFinish) then {
		throw (format [
			"There is no end trigger for stage %1 of course %2",
			_stage,
			_logicRoot
		]);
	};
	private _codeSetup = _stage getVariable competition_var_name_setup;
	private _codeTeardown = _stage getVariable competition_var_name_teardown;
	private _timeStart = time;
	_junk pushBack (
		createSimpleObject [
			"A3\Misc_F\Helpers\Sign_Arrow_F.p3d",
			[
				(getPosASL _stage) select 0,
				(getPosASL _stage) select 1,
				((getPosASL _stage) select 2) + 3
			],
			false
		]
	);
	{
		[
			format ["Proceed to stage %1!", _stageNumber]
		] remoteExec ["competition_fnc_hint", _x];
	} forEach _participants;

	// Waiting to start stage
	[format ["Waiting for stage %1 to start with trigger %2", _stageNumber, _triggerStart]] call competition_fnc_log;
	waitUntil {
		sleep 0.1;
		(triggerActivated _triggerStart) or 
		!IS_ACTIVE
	};
	{deleteVehicle _x} forEach _junk;
	if !IS_ACTIVE exitWith {
		[
			_logicRoot,
			_stage,
			_stageNumber,
			_participants,
			_codeTeardown,
			_junk,
			true
		]  call competition_fnc_cleanup;
		_isAborted = true;
	};

	// Started
	[format ["Stage %1 started!", _stageNumber]] call competition_fnc_log;
	{
		_x setVariable ["competition_hits", 0, true];
	} forEach _participants;
	_logicRoot setVariable ["competition_enemyKIA", 0];
	_logicRoot setVariable ["competition_civilianKIA", 0];
	[_logicRoot, _stage, _stageNumber, _participants] call _codeSetup;
	{
		[
			format ["Stage %1 started!", _stageNumber]
		] remoteExec ["competition_fnc_hint", _x];
	} forEach _participants;

	sleep 2;  // Allow time for spawning to avoid premature finish trigger
	
	// Waiting for stage to complete
	[format ["Waiting for stage %1 to finish with trigger %2", _stageNumber, _triggerFinish]] call competition_fnc_log;
	waitUntil {
		sleep 0.1;
		(triggerActivated _triggerFinish) or 
		!IS_ACTIVE
	};
	if !IS_ACTIVE exitWith {
		[
			_logicRoot,
			_stage,
			_stageNumber,
			_participants,
			_codeTeardown,
			_junk,
			true
		] call competition_fnc_cleanup;
		_isAborted = true;
	};

	// Stage complete! Do Scoring.
	[_logicRoot, _stage, _stageNumber, _participants] call _codeTeardown;
	_stageTime = (time - _timeStart);
	_totalTime = _totalTime + _stageTime;
	private _stageHits = 0;
	{
		_stageHits = _stageHits + (_x getVariable ["competition_hits", 0]);
	} forEach _participants;
	private _stageEnemyKIA = _logicRoot getVariable ["competition_enemyKIA", 0];
	private _stageCivKIA = _logicRoot getVariable ["competition_civilianKIA", 0];
	private _stageScore = round (_stageTime + (_stageHits * 10) + (_stageCivKIA * 50));
	_totalScore = _totalScore + _stageScore;

	_announcements pushBack (format [
		"Stage %1, in %2 seconds, %3 Enemy KIA, %4 Civilian KIA, recived %5 hits and used %6. Score: %7",
		_stageNumber,
		_stageTime,
		_stageEnemyKIA,
		_stageCivKIA,
		_stageHits,
		_logicRoot getVariable ["competition_weaponsUsed", []],
		_stageScore
	]);
	[format ["Stage %1 finished! Announcements so far: %2", _stageNumber, _announcements]] call competition_fnc_log;

	_logicRoot setVariable ["competition_weaponsUsed", []];

};

if !(_isAborted) then {
	// Wrapping up all the stages
	{
		[
			"Round Finished! see system chat and logs for scores."
		] remoteExec ["competition_fnc_hint", _x];
	} forEach _participants;
	[
		_logicRoot,
		objNull,
		-1,
		_participants,
		{},
		_junk,
		false
	] call competition_fnc_cleanup;

	// Announcements TODO: Add reporting to discord and maybe ZAS.
	if (_logicRoot getVariable ["competition_doAnnouncements", true]) then {
		_announcements pushBack (format [
			"Course total: Actual time %1, score time %2", _totalTime, _totalScore
		]);
		{
			diag_log format ["####### Competition announcement #######: %1", _x];
			[_x] remoteExec ["competition_fnc_systemChat", 0];
		} forEach _announcements;
	};
} else {
	{
		["Round aborted!"] remoteExec ["competition_fnc_hint", _x];
	} forEach _participants;
};
