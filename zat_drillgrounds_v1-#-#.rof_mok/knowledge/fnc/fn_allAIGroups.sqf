/*

    Author: Phoenix of Zulu-Alpha

    Description: Gets all groups that have no players.

    Params: None

    Returns:
        ARRAY - Of Groups.

*/

private "_groups";
private "_all_player_groups";

_all_player_groups = [];
{_all_player_groups pushBack (group _x)} forEach allPlayers;

_groups = [];
{
	if !(_x in _all_player_groups) then {
		_groups pushBack _x;
	};
} forEach allGroups;

_groups