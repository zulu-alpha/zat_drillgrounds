/*

    Author: Phoenix of Zulu-Alpha

    Description: Add the eventhandler to make hinting and scoring work.
	Due to the way `HitPart` works, it must be added to all clients and server.

    Params:
        0: OBJECT - Course object
        1: OBJECT - Object to initialize paintball mode for

    Returns: None

*/

params ["_course", "_participant"];

private _eh_id = _participant addEventHandler ["HitPart", {
	(_this select 0) params ["_target", "_shooter", "_bullet", "_position", "_velocity", "_selection", "_ammo", "_direction", "_radius", "_surface", "_direct"];
	private _target_hits = _target getVariable ["shoothouse_paintball_hits", 0];
	(
		format [
			"You where hit in the %1 by a %2 round! Total: %3",
			_selection, _ammo, _target_hits
		]
	) remoteExec ["hint", _target];
	_target_hits = _target_hits + 1;
	_target setVariable ["shoothouse_paintball_hits", _target_hits, true];
}];
_participant setVariable ["shoothouse_paintball_eh_id", _eh_id, false];
