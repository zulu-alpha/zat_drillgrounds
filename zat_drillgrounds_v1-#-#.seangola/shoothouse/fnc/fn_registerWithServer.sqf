/*

    Author: Phoenix of Zulu-Alpha

    Description: Add OwnerID to appropriate array

    Params:
        0: NUMBER - OwnerID of client
        1: STRING - 'hc' or 'player'

    Returns: None

*/

if !(isServer) exitWith {};


params ["_ownerId", "_type"];


if (_type == "player") exitWith {
    shoothouse_var_player_array set [count shoothouse_var_player_array, _ownerId];
};

if (_type == "hc") exitWith {
    shoothouse_var_hc_array set [count shoothouse_var_hc_array, _ownerId];
};
