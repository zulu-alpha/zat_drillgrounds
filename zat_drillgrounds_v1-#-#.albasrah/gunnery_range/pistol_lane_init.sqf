if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_lane_init.sqf started"};

_path = "gunnery_range\";

_lane = _this select 0;


_lane addaction [("<t color=""#FF3333"">" + ("Rotate target") + "</t>"), _path + "gun_rotate.sqf",[_lane]];
_lane addAction [("<t color=""#33CC33"">" + ("Freecam") + "</t>"),"zamf\debug\freecam.sqf"];

_lane addaction [("<t color=""#0000FF"">" + ("No Target") + "</t>"), _path + "gun_spawn.sqf",[_lane,"no_target"]];
_lane addaction [("<t color=""#0000FF"">" + ("Bullseye") + "</t>"), _path + "gun_spawn.sqf",[_lane,"WarfareBunkerSign"]];
_lane addaction [("<t color=""#0000FF"">" + ("Pop-up Target") + "</t>"), _path + "gun_spawn.sqf",[_lane,"TargetP_Inf_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("Infantry") + "</t>"), _path + "gun_spawn.sqf",[_lane,"I_Soldier_A_F"]];

_lane addaction [("<t color=""#fadfbe"">" + ("20m") + "</t>"), _path + "gun_move.sqf",[_lane,20]];
_lane addaction [("<t color=""#fadfbe"">" + ("50m") + "</t>"), _path + "gun_move.sqf",[_lane,50]];
_lane addaction [("<t color=""#fadfbe"">" + ("75m") + "</t>"), _path + "gun_move.sqf",[_lane,75]];


_lane addaction [("<t color=""#FF3333"">" + ("Monitor Target") + "</t>"), _path + "gun_hint.sqf",[_lane]];
_lane addaction [("<t color=""#FF3333"">" + ("Stop Monitoring") + "</t>"), _path + "gun_hintStop.sqf",[_lane]];

// Bullseye
_lane addaction [("<t color=""#FF9900"">" + ("Check scores") + "</t>"), _path + "una_targets_za\check_target.sqf", _lane, 1.5, false, true, '', "(typeOf (_target getVariable ['target', objNull]) == 'WarfareBunkerSign')"];
_lane addaction [("<t color=""#FF9900"">" + ("Clear target") + "</t>"), _path + "una_targets_za\clear_target.sqf", _lane, 1.5, false, true, '', "(typeOf (_target getVariable ['target', objNull]) == 'WarfareBunkerSign')"];

// Bullet Tracing

_path_trace = _path + "gun_tracing\";

_lane addaction [("<t color=""#0000FF"">" + ("Enable Bullet Tracing") + "</t>"), _path_trace + "trac_toggle.sqf", [true], 1.5, false, true, '', "!(zam_gun_var_isTrace)"];
_lane addaction [("<t color=""#0000FF"">" + ("Disable Bullet Tracing") + "</t>"), _path_trace + "trac_toggle.sqf", [false], 1.5, false, true, '', "zam_gun_var_isTrace"];
// Might not be needed if lifetime parameter is used
//_lane addaction [("<t color=""#0000FF"">" + ("Clear Trace Lines") + "</t>"), _path_trace + "trac_clear.sqf", nil, 1.5, false, true, '', "zam_gun_var_isTrace"];


 if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_lane_init.sqf finished"};