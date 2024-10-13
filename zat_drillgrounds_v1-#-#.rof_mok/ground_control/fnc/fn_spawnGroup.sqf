/*
    Description:
	Spawn the given number of enemy troops on the East side, randomly using units of the
	give types and registering them with the course via the given variable name in the 
	course's namespace.

    Params:
    0: OBJECT - Course object.
	1: NUMBER - Number of units to spawn.
    2: ARRAY - Of STRINGs of unit type names.
	3: ARRAY - Positional array in ATL.
	4: STRING - Variable name to use in course namespace.

    Returns: GROUP
*/

params ["_course", "_count", "_types", "_pos", "_variable_name"];

private _group = createGroup East;

[_group, _count, _types, _pos] spawn {
	params ["_group", "_count", "_types", "_pos"];
	for "_i" from 1 to _count do {
		private _type =  selectRandom _types;
		_group createUnit [_type, _pos, [], 0, "NONE"];
		sleep 2;
	};
};

_groups = _course getVariable [_variable_name, []];
_groups pushBackUnique _group;
_course setVariable [_variable_name, _groups];

_group