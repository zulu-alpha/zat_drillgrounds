if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "dist_move.sqf started"};

private ["_lane", "_target", "_dist", "_lane_pos", "_lane_dir", "_target_newPos"];

_lane = (_this select 3) select 0;
_dist = (_this select 3) select 1;

_lane_pos = getPosAtl _lane;
_lane_dir = getDir _lane;


_target_newPos = [(_lane_pos select 0) + _dist * (sin _lane_dir), (_lane_pos select 1) + _dist * (cos _lane_dir), 0];

_lane setVariable ["target_pos", _target_newPos, true];

_target = _lane getVariable ["target", objNull];

if (!isNull _target) then {
	_target setPosAtl _target_newPos;
};


if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "dist_move.sqf finished"};