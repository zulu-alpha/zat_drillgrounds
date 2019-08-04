params ["_cone"];

private _marker_z_offset = 0.5;
private _markers_index = [];
private _markers = [];

fnc_cleanup_markers = {
	{
		deleteVehicle _x;
	} forEach _markers;
	_markers = [];
	_markers_index = [];
};

fnc_create_marker = {
	params ["_player", "_know_pos"];
	if (_player in _markers_index) exitWith {
		systemChat format ["%1 already in marker index!", _player];
	};
	if (_player == player) then {
		private _marker_type = "Sign_Arrow_F";
	} else {
		private _marker_type = "Sign_Arrow_Blue_F";
	};

	private _pos = [_know_pos select 0, _know_pos select 1, ((ASLToATL eyepos _player) select 2) + _marker_z_offset];
	private _marker = _marker_type createVehicleLocal [0,0,0];

	_markers_index set [count _markers_index, _player];
	_markers set [_markers_index find _player, _marker];
	_marker setPosATL _pos;
};

fnc_update_marker = {
	params ["_i", "_player", "_know_pos"];
	private _marker = _markers select _i;

	private _pos = [_know_pos select 0, _know_pos select 1, ((ASLToATL eyepos _player) select 2) + _marker_z_offset];
	_marker setPosATL _pos;
};

fnc_forgetten_marker = {
	params ["_i"];
	private _marker = _markers select _i;
	_marker setPosATL [0,0,0];
};

fnc_update_or_create_marker = {
	params ["_player", "_know_pos", "_is_known"];
	private _i = _markers_index find _player;
	private _exists = (_i == -1);
	if (_exists and !(_is_known)) then {
		[_i] call fnc_forgetten_marker
	};

	if (!(_exists) and _is_known) then {
		[_player, _know_pos] call fnc_create_marker;
	};

	if (_exists and _is_known) then {
		[_i, _player, _know_pos] call fnc_update_marker;
	};
};

while {knowledge_monitoring} do {
	params ["_cone"];
	private _target = _cone getVariable ['target', objNull];
	if (isNull _target) then {
		hintSilent parseText format [
			"<t size='2' align='center'>No target</t>"
		];
		knowledge_monitoring = false;
	} else {
		private _k_array = _target targetKnowledge player; 
		private _other_players = [];
		private _other_players_names = [];
		{
			_other_players set [count _other_players, _x select 1];
			_other_players_names set [count _other_players_names, name (_x select 1)];
		} forEach (_target targetsQuery [player, west, "", [], 0]);

		hintSilent parseText format [
			"
			<t size='2' align='center'>You</t> <br /> 
			Knows about you: <t color='%1'>%2</t> <br /> 
			Level of knowledge of you: <t color='%1'>%3</t> <br /> 
			Knows about your group: <t color='%1'>%4</t> <br /> 
			last time it saw you: <t color='%1'>%5s ago</t> <br /> 
			last time you threatened it: <t color='%1'>%6s ago</t> <br /> 
			Knowledge of your side: <t color='%1'>%7</t> <br /> 
			Uncertainty of your position: <t color='%1'>%8m</t> <br /> 

			<t size='2' align='center'>Other players</t> <br />
			<t color='%1'>%9</t> <br /> 
			",
			"#FFFF00",
			_k_array select 1,
			_target knowsAbout player,
			_k_array select 0,
			time - (_k_array select 2),
			time - (_k_array select 3),
			_k_array select 4,
			_k_array select 5,
			_other_players_names sort true
		];

		[player, _k_array select 6, _k_array select 1] call fnc_update_or_create_marker;

		{
			private _k_array = _target targetKnowledge _x;
			[_x, _k_array select 6, _k_array select 1] call fnc_update_or_create_marker;
		} forEach _other_players;

	};
	sleep 0.2;
};
hint "";

call fnc_cleanup_markers;
