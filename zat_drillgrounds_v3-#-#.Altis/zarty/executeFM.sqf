/*
	Description:
	Executes the fire mission stored in the given artillery's "current_fm" variable.
	Also sends feedback to the given player's machine.

	Parameter(s):
	0: OBJECT - Artillery to do the shooting and sideChat from.
	1: OBJECT - Player whos host machine will receive feedback.
	2: STRING - Callsign for the artillery to use in feedback.

	Returns:
	Nothing
*/
params ["_arty", "_player", "_arty_callsign", "_arty_mag"];
diag_log format ["zarty_fnc_executeFM - _arty: %1 - _player: %2, _arty_callsign: %3", _arty, _player, _arty_callsign];
// Storing in arty namespace as no way to pass to EH
_arty setVariable ["requester", _player];
_arty setVariable ["callsign", _arty_callsign];
_arty setVariable ["arty_mag", _arty_mag];

_eh = {
	params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
	diag_log format [
		"zarty_fnc_executeFM.EH - _unit: %1 - _firer: %2 - _distance: %3 - _weapon: %4 - _muzzle: %5 - _mode: %6 - _ammo: %7 - _gunner: %8",
		_unit, _firer, _distance, _weapon, _muzzle, _mode, _ammo, _gunner
	];
	if (_unit == _firer) then {
		_arty = _unit;
		diag_log format ["zarty_fnc_executeFM.EH - current_fm: %1", _arty getVariable "current_fm"];
		_player = _arty getVariable "requester";
		_arty_callsign = _arty getVariable "callsign";
		_arty_mag = _arty getVariable "arty_mag";
		_current_fm = _arty getVariable "current_fm";
		_current_fm set [2, (_current_fm select 2) + 1];
		_rounds = _current_fm select 1;
		_rounds_fired = _current_fm select 2;
		if (_rounds_fired == 1) then {
			_message = format ["This is %1, shot, over", _arty_callsign];
			[_arty, _message, _player] call zarty_fnc_sideChat;
			_message = format ["This is %1, splash, over.", _arty_callsign];
			[_message, 5, _arty, _player, _arty_mag] spawn zarty_fnc_messageETATimed;
		};
		if (_rounds_fired >= _rounds) then {
			_message = format ["This is %1, rounds complete, over", _arty_callsign];
			[_arty, _message, _player] call zarty_fnc_sideChat;
			_current_fm set [2, 0];
			_message = format ["This is %1, fire mission complete, over.", _arty_callsign];
			[_message, 0, _arty, _player, _arty_mag] spawn zarty_fnc_messageETATimed;
			_arty removeEventHandler ["FiredNear", _current_fm select 3];
		};
		_arty setVariable ["curent_fm", _current_fm, true];
	};
};

_index = _arty addEventHandler ["FiredNear", _eh];
_current_fm = _arty getVariable "current_fm";
_current_fm set [3, _index];
_arty setVariable ["curent_fm", _current_fm, true];
_arty doArtilleryFire [_current_fm select 0, _arty_mag, _current_fm select 1];
diag_log format ["zarty_fnc_executeFM - current_fm: %1", _arty getVariable "current_fm"];
