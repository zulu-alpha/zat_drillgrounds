/*
	Description:
	Initialize the course control object, mainly by calling the function that adds 
	addactions.

	Parameter(s):
	0: OBJECT - Course control object.
	1: ARRAY - Array of strings representing objective area markers.
	2: ARRAY - Array of objects that are spawners.
	3: ARRAY - Array of unit typenames that are used when generating enemy groups.
	4: STRING - Area marker name for the entire course.

	Returns:
	Nothing
*/
params ["_course", "_objectives", "_spawners", "_enemy_types", "_course_marker"];

if (isServer) then {
	_course setVariable ["groundControl_isActive", false, true];
	_course setVariable ["groundControl_objectives", _objectives, false];
	_course setVariable ["groundControl_spawners", _spawners, false];
	_course setVariable ["groundControl_enemyTypes", _enemy_types, false];
	_course setVariable ["groundControl_courseMarker", _course_marker, false];
	_course setVariable ["groundControl_enemyGroups", [], false];
	_course setVariable ["groundControl_enemyDefenderRatio", 0.5, false];
	_course setVariable ["groundControl_enemyAttackerRatio", 1, false];
	_course setVariable ["groundControl_enemyAttackInterval", 10, false];
};

if (hasInterface) then {
	[_course, []] call groundControl_fnc_createMenu;
};


