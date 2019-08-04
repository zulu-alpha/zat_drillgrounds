params ["_cone"];

private _markers = [];
fnc_cleanup = {
	{
		deleteVehicle _x;
	} forEach _markers;
	_markers = [];
};

while {knowledge_monitoring} do {
	call fnc_cleanup;
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
			_other_players_names
		];

		private _pos = [(_k_array select 6) select 0, (_k_array select 6) select 1, ((ASLToATL eyepos player) select 2) + 0.5];
		private _marker = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		_markers set [count _markers, _marker];
		_marker setPosATL _pos;

		{
			private _k_array = _target targetKnowledge _x;
			private _pos = [(_k_array select 6) select 0, (_k_array select 6) select 1, ((ASLToATL eyepos _x) select 2) + 0.5];
			private _marker = "Sign_Arrow_Blue_F" createVehicleLocal _pos;
			_markers set [count _markers, _marker];
			_marker setPosATL _pos;
		} forEach _other_players;

	};
	sleep 0.2;
};
hint "";

call fnc_cleanup;
