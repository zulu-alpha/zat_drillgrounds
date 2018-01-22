if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_spawn.sqf started"};

private ["_lane", "_target_name", "_target_old", "_target_dir", "_junk_old", "_lane_dir", "_lane_pos", "_dist",
	"_target_pos", "_target_new", "_target_newGroup", "_junk_new", "_target_hint"];

_lane = (_this select 3) select 0;
_target_name = (_this select 3) select 1;
_target_script = (_this select 3) select 2;

_target_old = _lane getVariable ["target", objNull];
_target_dir = _lane getVariable ["target_dir", (getDir _lane) + 180];

_junk_old = _lane getVariable ["junk", []];

// For default position
_lane_pos = getPosAtl _lane;
_lane_dir = getDir _lane;
_dist = 20;

// Position with default at 20m
_target_pos = _lane getVariable ["target_pos",
	[(_lane_pos select 0) + _dist * (sin _lane_dir), (_lane_pos select 1) + _dist * (cos _lane_dir), 0]
];

// Delete old target(s)
if (!isNull _target_old) then {
	zam_gun_var_hintOn = false;
	{deleteVehicle _x} forEach _junk_old;
	deleteGroup (group _target_old);
};

waitUntil {count (nearestObjects [_target_pos, ["AllVehicles"], 4]) == 0};

if (_target_name != "no_target") then {
	// Spawn new target(s)
	_target_newGroup = createGroup east;
	_target_new = _target_newGroup createUnit [_target_name, _target_pos, [], 0, "NONE"];

	// If it's a vehicle, then nothing spawned and then
	// this code block will run to spawn a vehicle with crew
	if (!alive _target_new) then {
		_target_new = createVehicle [_target_name, _target_pos, [], 0, "NONE"];
		createVehicleCrew _target_new;
		_group_temp = group (crew _target_new select 0);

		// Check not an empty vehicle (pop-up target)
		if (!isNil "_group_temp") then {
			(units _group_temp) join _target_newGroup;
			deleteGroup _group_temp;
			_target_newGroup addVehicle _target_new;
		};

	};
	_lane setVariable ["target", _target_new, true];

	// Add all soldiers and their vehicle (if there is one)
	// to a junk list for easy future deletion
	_junk_new = + crew _target_new;
	if !((vehicle _target_new) in _junk_new) then {
		_junk_new set [count _junk_new, vehicle _target_new];
	};
	_lane setVariable ["junk", _junk_new, true];

	// Disable AI
	{
		_x disableAI "TARGET";
		_x disableAI "AUTOTARGET";
		_x disableAI "FSM";
		_x disableAI "MOVE";
		_x setunitpos "up";
		_x setBehaviour "CARELESS";
		_x setCombatMode "BLUE"
	} foreach units _target_new;

	// Direction
	if (count (crew _target_new) > 0) then {
		_target_new setDir _target_dir;
	// Set direction to front if pop-up target
	} else {
		_target_new setDir (getDir _lane);
	};

	// Make the crew watch forward
	[_target_new] spawn gun_watch;

	// Event handler for hint
	_target_new addEventHandler ["HitPart", {_this call gun_hitPart}];


	// Hint string
	waitUntil {!isNull _target_new};
	_target_hint = [_target_new] call gun_makeHint;
	_lane setVariable ["target_hint", _target_hint, true];

	[0,0,0,[_lane]] spawn gun_hint;

	if (typeOf _target_new == "WarfareBunkerSign") then {
		[_lane] execVm 'gunnery_range\una_targets_za\init_target.sqf'
	};

} else {
	zam_gun_var_hintOn = false;
	hint "";
	_lane setVariable ["target", objNull, true];
	_lane setVariable ["junk", [], true];
	_lane setVariable ["target_hint", "No Target", true];
};

if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_spawn.sqf finished"};