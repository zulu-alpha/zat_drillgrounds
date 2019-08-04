if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_init.sqf started"};

_path = "gunnery_range\";

gun_hitPart = compileFinal preprocessFileLineNumbers (_path + "gun_hitPart.sqf");
gun_makeHint = compileFinal preprocessFileLineNumbers (_path + "gun_makeHint.sqf");
gun_hint = compileFinal preprocessFileLineNumbers (_path + "gun_hint.sqf");
gun_watch = compileFinal preprocessFileLineNumbers (_path + "gun_watch.sqf");

zam_gun_var_hintOn = false;

// Bullet Tracing (generates functions for use)
call compile preprocessFileLineNumbers (_path + "gun_tracing\trac_script.sqf");
zam_gun_var_isTrace = false;

if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_init.sqf finished"};