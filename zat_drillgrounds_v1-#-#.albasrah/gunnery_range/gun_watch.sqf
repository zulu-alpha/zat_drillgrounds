if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_watch.sqf started"};

private ["_target", "_dir", "_watch_x", "_watch_y"];

_target = _this select 0; 

_dir = getdir _target;

_watch_x = (getpos _target select 0) + (10000 * (sin _dir));
_watch_y = (getpos _target select 1) + (10000 * (cos _dir));

//diag_log format ["watch _pos: %1", getpos _target];
if (!(isNil "zam_debug") && {zam_debug}) then {diag_log format ["_target: %1  watch _dir: %2",_target, _dir]};
//diag_log format ["watch _watchpos: %1", [_watch_x,_watch_y]];

{
	_x doWatch [_watch_x, _watch_y];
} foreach crew _target;

if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_watch.sqf started"};