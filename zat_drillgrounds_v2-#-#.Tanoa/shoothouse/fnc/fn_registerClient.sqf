/*

    Author: Phoenix of Zulu-Alpha

    Description: Has all machines register themselves with the server so it can track HCs and clients

    Params: None

    Returns: None

*/

if !(isMultiplayer) exitWith {};

if !(isServer) then {

    private _clientType = "player";

    if !(hasInterface) then {_clientType = "hc"};

    [clientOwner, _clientType] remoteExec ["shoothouse_fnc_registerWithServer", 2];

};
