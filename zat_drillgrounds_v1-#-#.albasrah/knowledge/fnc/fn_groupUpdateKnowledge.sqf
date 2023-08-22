/*

    Author: Phoenix of Zulu-Alpha

    Description: Updates the stored knowledge that a group has of the given player target,
	             only if the group is local and saves the information in a public object 
				 variable. The variable is `knowledge_of_<netid>` of the format:

					leader
				 	leader knowsAbout value,
					known by group
					known by the unit
					last time in seconds the target was seen by the unit - STRING
					last time in seconds the target endangered the unit - STRING
					target side
					position error
					target position
				 
				 where `<netid>` is the netid of each player.

				 Note that it asks for both the NetID and the object of the target player
				 even though one can be derived from the other by this function, for the 
				 sake of efficiency.

    Params:
		0: OBJECT - Group
		1: STRING - NetID of target player
		2: OBJECT - Object of player

    Returns: None

*/
params ["_group", "_player_ID", "_player"];

if (local _group) then {

	private _leader = leader _group;
	(_leader targetKnowledge _player) params [
		"_known_by_group",
		"_known_by_leader",
		"_last_seen",
		"_last_endangered",
		"_target_side",
		"_position_error",
		"_target_position"
	];
	private _knowledge = [
		_leader,
		_leader knowsAbout _player,
		_known_by_group,
		_known_by_leader,
		if (_last_seen <= 0) then {"N/A"} else {str (round (time - _last_seen))},
		if (_last_endangered <= 0) then {"N/A"} else {str (round (time - _last_endangered))},
		_target_side,
		_position_error,
		_target_position
	];
	_group setVariable [
		format ["knowledge_of_%1", _player_ID],
		_knowledge,
		true
	];

};
