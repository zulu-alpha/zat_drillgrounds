params ["_participant", "_cancelled"];

cqc_course setVariable ["course_isActive", false, true];
{[_x, objNull] remoteExec ["shootHouse_fnc_requestDeleteGroups", 2]}  forEach [cqc_shoothouse_1];
{deleteVehicle _x} forEach cqc_junk;

if !(_cancelled) then {
	private _finish_time = time;
	private _hits = _participant getVariable ["paintball_hits", 0];
	private _ekia = cqc_course getVariable ["course_enemy_kia", 0];
	private _ckia = cqc_course getVariable ["course_civ_kia", 0];
	private _time = round (_finish_time - (cqc_course getVariable ["course_startTime", 0]));
	private _score = round (_time + (_ckia * 15) + (_hits * 6));
	private _message = format ["Actual time: %1s, civ KIA + %2*15s, hits + %3*6s. Score: %4s", _time, _ckia, _hits, _score];
	diag_log format ["Competition cqc scoring for %1, time: %2s, hits: %3, EKIA %4, CKIA %5, Score: %6s", name _participant, _time, _hits, _ekia, _ckia, _score];
	diag_log _message;
	[_participant, _message] remoteExec ["sideChat", 0];
} else {
	[_participant, "Course run cancelled!"] remoteExec ["sideChat", 0];
};
