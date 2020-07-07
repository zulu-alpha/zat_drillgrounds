/*

    Author: Phoenix of Zulu-Alpha

    Description: Spawns the given unit with build in handicaps to make it suitable for CQC.

    Params:
        0: GROUP
		1: STRING - Config name 
		2: ARRAY - Positional array in ATL
		3: NUMBER - Direction to face the unit
		4: STRING - Stance
		5: BOOL - True to make them shoot at their opposition.
		6: NUMBER - Skill level

    Returns: None

*/
params ["_group", "_type", "_pos", "_dir", "_stance", "_live", "_skill"];

private _target_object = _group createUnit [_type, [0,0,0], [], 0, "NONE"];
_target_object disableAI "PATH";
_target_object setPosATL _pos;
_target_object setFormDir _dir;
_target_object setDir _dir;
(group _target_object) setBehaviour "SAFE";

// Live setting
if !(_live) then {
	_target_object setCombatMode "BLUE";
};

// Skill setting
_target_object setSkill _skill;
_target_object setVariable ["dangerAIEnabled",false];

// Unit Pos
_unitPos_mapping_index = shoothouse_var_stance_mapping find _stance;
private _unitPos = if (_unitPos_mapping_index >= 0) then {
		shoothouse_var_unitPos_mapping select _unitPos_mapping_index
	} else {
		"AUTO"
};
_target_object setUnitPos _unitPos;