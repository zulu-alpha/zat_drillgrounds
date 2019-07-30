if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_lane_init.sqf started"};

_path = "gunnery_range\";

_lane = _this select 0;


_lane addaction [("<t color=""#FF3333"">" + ("Rotate target") + "</t>"), _path + "gun_rotate.sqf",[_lane]];
_lane addAction [("<t color=""#33CC33"">" + ("Freecam") + "</t>"),"zamf\debug\freecam.sqf"];

_lane addaction [("<t color=""#0000FF"">" + ("No Target") + "</t>"), _path + "gun_spawn.sqf",[_lane,"no_target"]];
_lane addaction [("<t color=""#0000FF"">" + ("Bullseye") + "</t>"), _path + "gun_spawn.sqf",[_lane,"WarfareBunkerSign"]];
_lane addaction [("<t color=""#0000FF"">" + ("Pop-up Target") + "</t>"), _path + "gun_spawn.sqf",[_lane,"TargetP_Inf_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("Infantry") + "</t>"), _path + "gun_spawn.sqf",[_lane,"I_Soldier_A_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("IMV") + "</t>"), _path + "gun_spawn.sqf",[_lane,"I_MRAP_03_hmg_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("MRAP") + "</t>"), _path + "gun_spawn.sqf",[_lane,"O_MRAP_02_hmg_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("APC") + "</t>"), _path + "gun_spawn.sqf",[_lane,"O_APC_Wheeled_02_rcws_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("IFV") + "</t>"), _path + "gun_spawn.sqf",[_lane,"O_APC_Tracked_02_cannon_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("Cold War MBT") + "</t>"), _path + "gun_spawn.sqf",[_lane,"CUP_O_T72_TKA"]];
_lane addaction [("<t color=""#0000FF"">" + ("Modern MBT") + "</t>"), _path + "gun_spawn.sqf",[_lane,"I_MBT_03_cannon_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("Truck, Cargo") + "</t>"), _path + "gun_spawn.sqf",[_lane,"I_Truck_02_covered_F"]];
_lane addaction [("<t color=""#0000FF"">" + ("Gunship") + "</t>"), _path + "gun_spawn.sqf",[_lane,"O_Heli_Attack_02_black_F"]];

_lane addaction [("<t color=""#fadfbe"">" + ("20m") + "</t>"), _path + "gun_move.sqf",[_lane,20]];
_lane addaction [("<t color=""#fadfbe"">" + ("50m") + "</t>"), _path + "gun_move.sqf",[_lane,50]];
_lane addaction [("<t color=""#fadfbe"">" + ("100m") + "</t>"), _path + "gun_move.sqf",[_lane,100]];
_lane addaction [("<t color=""#fadfbe"">" + ("150m") + "</t>"), _path + "gun_move.sqf",[_lane,150]];
_lane addaction [("<t color=""#fadfbe"">" + ("200m") + "</t>"), _path + "gun_move.sqf",[_lane,200]];
_lane addaction [("<t color=""#fadfbe"">" + ("250m") + "</t>"), _path + "gun_move.sqf",[_lane,250]];
_lane addaction [("<t color=""#fadfbe"">" + ("300m") + "</t>"), _path + "gun_move.sqf",[_lane,300]];
_lane addaction [("<t color=""#fadfbe"">" + ("350m") + "</t>"), _path + "gun_move.sqf",[_lane,350]];
_lane addaction [("<t color=""#fadfbe"">" + ("400m") + "</t>"), _path + "gun_move.sqf",[_lane,400]];
_lane addaction [("<t color=""#fadfbe"">" + ("500m") + "</t>"), _path + "gun_move.sqf",[_lane,500]];
_lane addaction [("<t color=""#fadfbe"">" + ("600m") + "</t>"), _path + "gun_move.sqf",[_lane,600]];
_lane addaction [("<t color=""#fadfbe"">" + ("700m") + "</t>"), _path + "gun_move.sqf",[_lane,700]];
_lane addaction [("<t color=""#fadfbe"">" + ("800m") + "</t>"), _path + "gun_move.sqf",[_lane,800]];
_lane addaction [("<t color=""#fadfbe"">" + ("900m") + "</t>"), _path + "gun_move.sqf",[_lane,900]];
_lane addaction [("<t color=""#fadfbe"">" + ("1000m") + "</t>"), _path + "gun_move.sqf",[_lane,1000]];
_lane addaction [("<t color=""#fadfbe"">" + ("1100m") + "</t>"), _path + "gun_move.sqf",[_lane,1100]];
_lane addaction [("<t color=""#fadfbe"">" + ("1200m") + "</t>"), _path + "gun_move.sqf",[_lane,1200]];
_lane addaction [("<t color=""#fadfbe"">" + ("1300m") + "</t>"), _path + "gun_move.sqf",[_lane,1300]];
_lane addaction [("<t color=""#fadfbe"">" + ("1400m") + "</t>"), _path + "gun_move.sqf",[_lane,1400]];
_lane addaction [("<t color=""#fadfbe"">" + ("1500m") + "</t>"), _path + "gun_move.sqf",[_lane,1500]];
_lane addaction [("<t color=""#fadfbe"">" + ("1600m") + "</t>"), _path + "gun_move.sqf",[_lane,1600]];
_lane addaction [("<t color=""#fadfbe"">" + ("1700m") + "</t>"), _path + "gun_move.sqf",[_lane,1700]];
_lane addaction [("<t color=""#fadfbe"">" + ("1800m") + "</t>"), _path + "gun_move.sqf",[_lane,1800]];
_lane addaction [("<t color=""#fadfbe"">" + ("1900m") + "</t>"), _path + "gun_move.sqf",[_lane,1900]];
_lane addaction [("<t color=""#fadfbe"">" + ("2000m") + "</t>"), _path + "gun_move.sqf",[_lane,2000]];
_lane addaction [("<t color=""#fadfbe"">" + ("2100m") + "</t>"), _path + "gun_move.sqf",[_lane,2100]];

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