/*

    Author: Phoenix of Zulu-Alpha

    Description: Spawns a random number and set of units at a random position relative to
                 the given reference object. Also registers them with the reference object

    Params:
        0: OBJECT - Reference object.

    Returns: None

*/

if !(isServer) exitWith {};

_this spawn {

	params ["_refObject"];

	_refObject setVariable ["roundInProgress", true, true];

	private _participants = _refObject getVariable ["participants", []];
	private _observers = _refObject getVariable ["observers", []];
	if (count _participants == 0) exitWith {
		_refObject setVariable ["roundInProgress", false, true];
	};
	private _group = [_refObject] call threeddrill_fnc_spawnRandomGroup;
	{
		_x allowDamage false;
	} forEach (units _group);
	{
		["Round started!"] remoteExec ["threeddrill_fnc_hint", _x];
		[_x, _group] remoteExec ["threeddrill_fnc_revealGroup", _x];
	} forEach (_participants + _observers);
	private _startTime = time;

	waitUntil {sleep 0.1; [_participants, _group] call threeddrill_fnc_isAllCursorsOnTargets};
	{
		["All Seen!"] remoteExec ["threeddrill_fnc_hint", _x];
	} forEach (_participants + _observers);

	{
		_x allowDamage true;
	} forEach (units _group);

	waitUntil {
		{
			private _isUnconscious = _x getVariable ["ace_isunconscious", false];
			!(isNull _x) and {alive _x} and {canFire _x} and {!(_isUnconscious)}
		} count (units _group) == 0
	};

	private _timeElapsed = time - _startTime;
	{
		[format ["Round finished in %1s", _timeElapsed]] remoteExec ["threeddrill_fnc_hint", _x];
	} forEach (_participants + _observers);

	{deleteVehicle _x} forEach (units _group);

	_refObject setVariable ["roundInProgress", false, true];

};