/*
	Description:
	Gives the given fire mission message to the given player at the given time before 
	the time it takes for a shell to reach the target stored in the artillery's current_fm
	variable.
	Intended to be used for 'splash' (called when the first round is fired for 5 seconds 
	before ETA of that round) and 'fire mission complete' (called when the last round is 
	fired for 0 seconds before ETA, so just as the last round lands).

	Parameter(s):
	0: STRING - Message.
	1: NUBMER - Seconds before time of flight is completed to send the message.
	2: OBJECT - Artillery.
	3: OBJECT - Player whos host machine will receive feedback.
	4: STRING - Ammunition type to compute flight time with.

	Returns:
	Nothing
*/
params ["_message", "_seconds_before_eta", "_arty", "_player", "_arty_mag"];
diag_log format [
	"zarty_fnc_messageETATimed - _message: %1 - _seconds_before_eta: %2 - _arty: %3 - _player %4",
	_message,
	_seconds_before_eta,
	_arty,
	_player
];
_current_fm = _arty getVariable "current_fm";
_time_to_target = _arty getArtilleryETA [_current_fm select 0, _arty_mag];
_message_time = time + _time_to_target - _seconds_before_eta;
diag_log format [
	"zarty_fnc_messageETATimed - _time: %1 - _time_to_target: %2 - _seconds_before_eta: %3 -  _message_time: %4",
	time, _time_to_target, _seconds_before_eta, _message_time
];
waitUntil {time >= _message_time};
[_arty, _message, _player] call zarty_fnc_sideChat;
