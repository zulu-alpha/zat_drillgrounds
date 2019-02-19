pvpfw_chatIntercept_allCommands = [
	[
		ARTY_CALLSIGN,
		{
			private _arg = toLower (_this select 0);
			diag_log format ["zarty - _arg: %1", _arg];
			if ((_arg find "requesting fire mission") != -1) exitWith {
				_current_fm = [nil, nil, 0, nil];  // [grid, rounds, rounds fired, eh_index]
				ARTY setVariable ["current_fm", _current_fm, true];

				// Grid
				_grid_pos = [_arg] call get_grid;
				if (isNil "_grid_pos") exitWith {};
				_current_fm set [0, _grid_pos];

				// Rounds
				_rounds_num =  [_arg] call get_rounds;
				if (isNil "_rounds_num") exitWith {};
				_current_fm set [1, _rounds_num];

				ARTY setVariable ["current_fm", _current_fm, true];

				_message = format [
					"This is %1, Fire mission received for grid %2 for %3 rounds, over.",
					ARTY_CALLSIGN,
					[_grid_pos select 0, _grid_pos select 1] call pos_to_map_grid,
					_rounds_num
				];
				[ARTY, _message, player] call zarty_fnc_sideChat;

				_initial_error = [
					(random ARTY_ERROR_RADIUS * 2) - ARTY_ERROR_RADIUS,
					(random ARTY_ERROR_RADIUS * 2) - ARTY_ERROR_RADIUS
				];
				diag_log format ["zarty - initial_error: %1", _initial_error];
				_in_range = _initial_error call calculate_fm;
				if !(_in_range) exitWith {};

				[ARTY, player, ARTY_CALLSIGN, ARTY_MAG] remoteExec ["zarty_fnc_executeFM", 2];
			};

			if ((_arg find "adjust fire") != -1) exitWith {
				_current_fm = ARTY getVariable "current_fm";
				if (isNil "_current_fm") exitWith {
					_message = format ["This is %1, there is no fire mission to correct for, over.", ARTY_CALLSIGN];
					[ARTY, _message, player] call zarty_fnc_sideChat;
				};
				_distance = [_arg] call get_adjust_distance;
				if (isNil "_distance") exitWith {};
				_direction = [_arg] call get_adjust_direction;
				if (isNil "_direction") exitWith {};
				_adjustment = [_distance, _direction] call get_adjustement;
				_in_range = _adjustment call calculate_fm;
				if !(_in_range) exitWith {};

				_message = format [
					"This is %1, Fire mission adjustment received of %2 meters bearing %3 degrees, out.",
					ARTY_CALLSIGN,
					_distance,
					_direction
				];
				[ARTY, _message, player] call zarty_fnc_sideChat;
			};

			if ((_arg find "repeat") != -1) exitWith {
				_rounds_num =  [_arg] call get_rounds;
				if (isNil "_rounds_num") exitWith {};
				_current_fm = ARTY getVariable "current_fm";
				_current_fm set [1, _rounds_num];
				ARTY setVariable ["current_fm", _current_fm, true];

				_grid_pos = _current_fm select 0;
				_message = format [
					"This is %1, Fire mission received for grid %2 for %3 rounds, over.",
					ARTY_CALLSIGN,
					[_grid_pos select 0, _grid_pos select 1] call pos_to_map_grid,
					_current_fm select 1
				];
				[ARTY, _message, player] call zarty_fnc_sideChat;

				[ARTY, player, ARTY_CALLSIGN, ARTY_MAG] remoteExec ["zarty_fnc_executeFM", 2];
			};

			_message = format ["This is %1, request fire mission with `requesting fire mission grid xxxyyy x rounds`, adjust fire with `adjust fire xx meters north/south/east/west`, or 'repeat x rounds' over.", ARTY_CALLSIGN];
			[ARTY, _message, player] call zarty_fnc_sideChat;
		}
	]
];

get_grid = {
	params ["_arg"];
	diag_log format ["zarty_get_grid - _arg: %1", _arg];
	_grid_index = _arg find "grid";
	if (_grid_index == -1) exitWith {
		_message = format ["This is %1, you didn't announce a grid with 'grid xxxyyy' over.", ARTY_CALLSIGN];
		[ARTY, _message, player] call zarty_fnc_sideChat;
		nil
	};
	_grid_arr = toArray _arg;
	_grid_arr deleteRange [0, _grid_index + 5];
	_grid_arr resize 6;
	_grid_str = toString _grid_arr;
	_grid_pos = (_grid_str call BIS_fnc_gridToPos) select 0;
	_grid_pos set [2, 0];  // Function only gives [x,y]
	diag_log format ["zarty_get_grid - return: %1", _grid_pos];
	_grid_pos
};

pos_to_map_grid = {
	// mapGridPosition doesn't pick up odd hundres of meters (e.g: [1300,1000] comes 
	// out as "012010" as opposed to "013010" as expected), so this is used instead.
	params ["_x_num", "_y_num"];
	diag_log format ["pos_to_map_grid - _x_num: %1 - _y_num: %2", _x_num, _y_num];
	// Make sure the last 2 digits are dropped
	_x_num = round (_x_num / 100);
	_y_num = round (_y_num / 100);
	_x_str = str(_x_num);
	_y_str = str(_y_num);
	// Make sure there are 3 digits. If not then add leading "0"s
	while {[_x_str] call CBA_fnc_strLen < 3} do {_x_str = "0" + _x_str};
	while {[_y_str] call CBA_fnc_strLen < 3} do {_y_str = "0" + _y_str};
	// Return the string
	_return = format ["%1%2", _x_str, _y_str];
	diag_log format ["zarty_pos_to_map_grid - return: %1", _return];
	_return
};

get_rounds = {
	params ["_arg"];
	diag_log format ["zarty_get_rounds - _arg: %1", _arg];
	_rounds_index = _arg find "round";
	if (_rounds_index == -1) exitWith {
		_message = format ["This is %1, you didn't specify your number of rounds with `xx rounds`, over.", ARTY_CALLSIGN];
		[ARTY, _message, player] call zarty_fnc_sideChat;
		nil
	};
	_rounds_arr = toArray _arg;
	_rounds_arr deleteRange [0, _rounds_index - 3];
	_rounds_arr resize 2;
	_rounds_str = toString _rounds_arr;
	_return = parseNumber _rounds_str;
	diag_log format ["zarty_get_rounds - return: %1", _return];
	_return
};

calculate_fm = {
	params ["_adjust_x", "_adjust_y"];
	diag_log format ["zarty_calculate_fm - _adjust_x: %1 - _adjust_y: %2", _adjust_x, _adjust_y];
	_current_fm = ARTY getVariable "current_fm";
	_grid = _current_fm select 0;
	_x = (_grid select 0) + _adjust_x;
	_y = (_grid select 1) + _adjust_y;
	_new_pos = [_x, _y, 0];
	_current_fm set [0, _new_pos];
	ARTY setVariable ["current_fm", _current_fm, true];
	_in_range = _new_pos inRangeOfArtillery [[ARTY], ARTY_MAG];
	if !(_in_range) then {
		_message = format ["This is %1, we are not in range for your fire mission, over.", ARTY_CALLSIGN];
		[ARTY, _message, player] call zarty_fnc_sideChat;
	};
	diag_log format ["zarty_calculate_fm - return: %1", _in_range];
	_in_range
};

get_adjust_distance = {
	params ["_arg"];
	diag_log format ["zarty_get_adjust_distance - _arg: %1", _arg];
	_distance_index = _arg find "meters";
	if (_distance_index == -1) exitWith {
		_message = format ["This is %1, you didn't specify your correction distance with `xx meters`, over.", ARTY_CALLSIGN];
		[ARTY, _message, player] call zarty_fnc_sideChat;
		nil
	};
	_distance_arr = toArray _arg;
	_distance_arr deleteRange [0, _distance_index - 4];
	_distance_arr resize 3;
	_distance_str = toString _distance_arr;
	_return = parseNumber _distance_str;
	diag_log format ["zarty_get_adjust_distance - return: %1", _return];
	_return
};

get_adjust_direction = {
	params ["_arg"];
	diag_log format ["zarty_get_adjust_direction - _arg: %1", _arg];
	_directions = [
		_arg find "north" > -1,
		_arg find "east" > -1,
		_arg find "south" > -1,
		_arg find "west" > -1
	];
	if (_directions isEqualTo [true, false, false, false]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 0];
		0
	};
	if (_directions isEqualTo [true, true, false, false]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 45];
		45
	};
	if (_directions isEqualTo [false, true, false, false]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 90];
		90
	};
	if (_directions isEqualTo [false, true, true, false]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 135];
		135
	};
	if (_directions isEqualTo [false, false, true, false]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 180];
		180
	};
	if (_directions isEqualTo [false, false, true, true]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 225];
		225
	};
	if (_directions isEqualTo [false, false, false, true]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 270];
		270
	};
	if (_directions isEqualTo [true, false, false, true]) exitWith {
		diag_log format ["zarty_get_adjust_direction - return: %1", 315];
		315
	};
	_message = format ["This is %1, you didn't specify your correction direction with `north/south/east/west`, over.", ARTY_CALLSIGN];
	[ARTY, _message, player] call zarty_fnc_sideChat;
	nil
};

get_adjustement = {
	params ["_distance", "_direction"];
	diag_log format ["zarty_get_adjustement - _distance: %1 - _direction: %2", _distance, _direction];
	_return = [round (_distance * (sin _direction)), round (_distance * (cos _direction))];
	diag_log format ["zarty_get_adjustement - return: %1", _return];
	_return
};
