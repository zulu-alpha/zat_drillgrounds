/*
	Description:
	Initialize the round for the ground control course.
	Must be executed on server

	Parameter(s):
	0: OBJECT - Course control object.

	Returns:
	Nothing
*/
params ["_course"];

_course setVariable ["groundControl_isActive", true, true];

private _objectives = _course getVariable ["groundControl_objectives", []];
private _enemy_types = _course getVariable ["groundControl_enemyTypes", []];
private _course_marker = _course getVariable ["groundControl_courseMarker", ""];
private _enemy_defender_ratio = _course getVariable ["groundControl_enemyDefenderRatio", 0.5];

private _bluforce_strength = [_course_marker, WEST] call groundControl_fnc_getAreaSideStrength;

// Initialize course by putting defensive groups in each objective area.
{
	private _obj_pos = getMarkerPos _x;
	[
		_course,
		_bluforce_strength * _enemy_defender_ratio,
		_enemy_types,
		_obj_pos,
		"groundControl_enemyGroups"
	] call groundControl_fnc_spawnGroup;
} forEach _objectives;

// Continually update marker areas
[_course, _objectives] spawn {
	params ["_course", "_objectives"];
	while {_course getVariable ["groundControl_isActive", false]} do {
		{
			[_x] call groundControl_fnc_processObjectiveArea;
		} forEach _objectives;
		sleep 10;
	};
};

// Attack loop
[_course] spawn {
	params ["_course"];
	while {_course getVariable ["groundControl_isActive", false]} do {
		private _objectives = _course getVariable ["groundControl_objectives", []];
		private _spawners = _course getVariable ["groundControl_spawners", []];
		private _enemy_types = _course getVariable ["groundControl_enemyTypes", []];
		private _course_marker = _course getVariable ["groundControl_courseMarker", ""];
		private _enemy_attacker_ratio = _course getVariable ["groundControl_enemyAttackerRatio", 1];
		private _enemy_defender_ratio = _course getVariable ["groundControl_enemyDefenderRatio", 0.5];
		private _enemy_attack_interval = _course getVariable ["groundControl_enemyAttackInterval", 300];

		private _bluforce_strength = [_course_marker, WEST] call groundControl_fnc_getAreaSideStrength;

		private _spawner = objNull;
		if (({alive _x} count _spawners) > 0) then {
			while {!(alive _spawner)} do {
				_spawner = selectRandom _spawners;
			};
		};

		if (alive _spawner) then {
			// Attack all marker areas that are blufor held
			private _enemy_objectives = [west, _objectives] call groundControl_fnc_getAllAreasOfSide;
			if (count _enemy_objectives > 0) then {
				private _obj_pos = getMarkerPos (selectRandom _enemy_objectives);
				private _attack_group = [
					_course,
					_bluforce_strength * _enemy_attacker_ratio,
					_enemy_types,
					getPos _spawner,
					"groundControl_enemyGroups"
				] call groundControl_fnc_spawnGroup;
				_wp = _attack_group addWaypoint [_obj_pos, 20];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "AWARE";
			};

			// Re-occupy empty objectives
			private _enemy_objectives = [sideEmpty, _objectives] call groundControl_fnc_getAllAreasOfSide;
			if (count _enemy_objectives > 0) then {
				private _obj_pos = getMarkerPos (selectRandom _enemy_objectives);
				private _attack_group = [
					_course,
					_bluforce_strength * _enemy_defender_ratio,
					_enemy_types,
					getPos _spawner,
					"groundControl_enemyGroups"
				] call groundControl_fnc_spawnGroup;
				_wp = _attack_group addWaypoint [_obj_pos, 20];
				_wp setWaypointType "MOVE";
				_wp setWaypointBehaviour "AWARE";
			};
		};

		sleep _enemy_attack_interval;
	};
};
