/*

    Author: Phoenix of Zulu-Alpha

    Description: Add the eventhandler to make hinting and scoring work.
	Due to the way `HitPart` works, it must be added to all clients and server.

    Params:
        0: OBJECT - Object to add the eventHandler to

    Returns: None

*/

params ["_participant"];

_participant setVariable ["competition_hits", 0, true];

private _eh_id = _participant addEventHandler ["HitPart", {
	(_this select 0) params ["_target", "_shooter", "_bullet", "_position", "_velocity", "_selection", "_ammo", "_direction", "_radius", "_surface", "_direct"];
	private _targetHits = _target getVariable ["competition_hits", 0];
	([
		format [
			"You where hit on %1 by a %2 round! Total: %3",
			_selection, _ammo select 4, _targetHits
		]
	]) remoteExec ["competition_fnc_hint", _target];
	_targetHits = _targetHits + 1;
	_target setVariable ["competition_hits", _targetHits, true];
}];
_participant setVariable ["competition_HitEhId", _eh_id, false];
