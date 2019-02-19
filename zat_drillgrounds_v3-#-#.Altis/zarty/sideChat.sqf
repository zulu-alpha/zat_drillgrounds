/*
	Description:
	Sends given message to client where given object is local and log it.

	Parameter(s):
	0: OBJECT - Object doing the sideChat
	1: STRING - Message
	2: OBJECT - Object whos host machine will receive the message

	Returns:
	Nothing
*/
params ["_arty", "_message", "_player"];
diag_log format ["zarty_fnc_sideChat -_arty: %1 -_message: %2 - _player: %3", _arty, _message, _player];
_message remoteExec ["hint", _player];
