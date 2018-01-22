if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_rotate.sqf started"};

private ["_lane", "_target", "_target_oldDir", "_target_newDir"];

_lane = (_this select 3) select 0;
_target = _lane getVariable ["target", objNull];

if (isNull _target) exitWith {if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "dist_rotate.sqf finished (no target)"}};

// Get new direction
_target_oldDir = getDir _target;
_target_newDir = _target_oldDir + 45;

// Avoid going over 360 degrees
if (_target_newDir >= 360) then {
	_target_newDir = _target_newDir - 360;
};

// Set direction
_lane setVariable ["target_dir", _target_newDir, true];
_target setDir _target_newDir;

// watch new direction
[_target] spawn gun_watch;

if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_rotate.sqf finished"};