/*

    Author: Phoenix of Zulu-Alpha

    Description: Runs local group update, circle drawing and draw job tasks in a loop for
	             all groups regardless of locality.

    Params: None

    Returns: None

*/

[] spawn {
	missionNamespace setVariable ["knowledge_isActive", true, true];

	private ["_eh_index", "_drawJobs"];
	if (hasInterface) then {
		Knowledge_circles = [false] call CBA_fnc_createNamespace;
		Knowledge_lastPosError = [false] call CBA_fnc_createNamespace;
		_drawJobs = [[], []];
		_eh_index = addMissionEventHandler ["Draw3D", {call knowledge_fnc_draw}];
	};

	while {sleep 0.5; knowledge_isActive} do {

		if (hasInterface) then {
			knowledge_drawJobs = +_drawJobs;
			_drawJobs = [[], []];
		};

		{
			private _group = _x;
			private _group_ID = _group call BIS_fnc_netId;
			{
				if (hasInterface) then {
					private _player_ID = _x call BIS_fnc_netId;
					[_group, _player_ID, _x] call knowledge_fnc_groupUpdateKnowledge;
					private _knowledge = _group getVariable [
						format ["knowledge_of_%1", _player_ID],
						nil
					];
					_knowledge params [
						"_leader",
						"_knows_about_level",
						"_known_by_group",
						"_known_by_leader",
						"_last_seen",
						"_last_endangered",
						"_target_side",
						"_position_error",
						"_target_position"
					];
					if (
							((leader _group) distance _x) < 150 and
							{{alive _x} count (units _group) > 0}
						) then {
						(_drawJobs select 1) pushBackUnique _group;
					};
					if (
							(_knows_about_level > 0) and
							{{alive _x} count (units _group) > 0}
						) then {
						[
							_group_ID, 
							_player_ID, 
							_target_position, 
							_position_error,
							Knowledge_circles,
							Knowledge_lastPosError
						] call knowledge_fnc_updateCircle;
						(_drawJobs select 0) pushBack [
							_leader,
							_knows_about_level,
							_known_by_leader,
							_last_seen,
							_last_endangered,
							_target_side,
							_target_position,
							_x
						];
					} else {
						private _var_name_circles = format [
							"knowledge_circleObjects_%1_for_%2",
							_group_ID,
							_player_ID
						];
						[
							_var_name_circles,
							Knowledge_circles
						] call knowledge_fnc_deleteCircle;
					};
				};
			} forEach (allPlayers - entities "HeadlessClient_F");

		} forEach (call knowledge_fnc_allAIGroups);

	};

	// Cleanup after turning off
	{
		[_x, Knowledge_circles] call knowledge_fnc_deleteCircle;
	} forEach (allVariables Knowledge_circles);

	if (hasInterface) then {removeMissionEventHandler ["Draw3D", _eh_index]};

};
