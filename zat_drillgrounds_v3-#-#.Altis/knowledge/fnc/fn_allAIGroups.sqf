/*

    Author: Phoenix of Zulu-Alpha

    Description: Gets all groups that are has no players.

    Params: None

    Returns:
        ARRAY - Of Groups.

*/

private "_groups";
private "_all_player_groups";

_all_player_groups = [];
{_all_player_groups pushBackUnique (group _x)} forEach allPlayers;

_groups = [];
{
	if ((local _x) and !(_x in _all_player_groups)) then {
		_groups pushBackUnique _x;
	};
} forEach allGroups;

_groups