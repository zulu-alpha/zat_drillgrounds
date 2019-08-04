// Wait until in an unconscious state then start spectator and exit when no longer in one and alive.
// Ace fnc returns true if unconcsious

// Only execute once
if !(isNil "training_var_spect_uncon") exitWith {};
training_var_spect_uncon = true;

    training_fnc_getSuitableCurator = {
        /*
            Return an unused curator with no addons enabled, or objNull if none found
        */
        private _ret = {
            if (isNull (getAssignedCuratorUnit _x) and (count (curatorAddons _x) == 0 )) exitWith {_x};
            objNull
        } forEach allCurators;
        _ret
    };

    training_fnc_alreadyAssignedCurator = {
        /*
            Returns true if given player is already assigned to a curator
            0: Player
            Return Bool
        */
        params ["_player"];
        private _ret = {
            if (_player == getAssignedCuratorUnit _x) exitWith {true};
            false
        } forEach allCurators;
        _ret
    };

    training_fnc_setCurator = {
        /*
            Assigns the passed in curator to the player and forces a tiny editable area (1)
            0: Curator
            1: Player
            Return None
        */
        params ["_curator", "_player"];

        _player assignCurator _curator;
        _curator addCuratorEditingArea [1, position _player, 0];
        _curator setCuratorEditingAreaType true;
        _curator addCuratorEditableObjects [playableUnits, false];

    };

    training_fnc_unsetCurator = {
        /*
            Unassigns the passed in curator area and removes the editing area (1)
            0: Curator
        */
        params ["_curator"];

        unassignCurator _curator;
    };

    training_fnc_neuterCurator = {
        /*
            Neuter given vurator by removing all editable onjects
            0: Curator
        */
        params ["_curator"];

        _curator removeCuratorEditableObjects [vehicles,true];
        _curator removeCuratorEditableObjects [(allMissionObjects "Man"),false];
        _curator removeCuratorEditableObjects [(allMissionObjects "Air"),true];
        _curator removeCuratorEditableObjects [(allMissionObjects "Ammo"),false];
    };


// Make all addonless curators unable to edit anything
if (isServer) then {
    {
        if (count (curatorAddons _x) == 0 ) then {
            [_x] call training_fnc_neuterCurator;
        };
    } count allCurators;
};


if !(hasInterface) exitWith{};
waitUntil {!(isNull player)};

// Skip loop if already has curator
if ([player] call training_fnc_alreadyAssignedCurator) exitWith {};

[] spawn {

    while {sleep 3; true} do {

        // If unconcsious, spectate
        if (player getVariable ["ACE_isUnconscious", false] and (alive player)) then {
            // Delay to make sure stay unconscious for long enough and if still unconscious, continue
            sleep 13;
            if (player getVariable ["ACE_isUnconscious", false] and (alive player)) then {
                private _curator = call training_fnc_getSuitableCurator;
                // If room to spectate, then continue
                if !(isNull _curator) then {
                    [_curator, player] remoteExecCall ["training_fnc_setCurator", 2];
                    sleep 2;    // Delay to allow open interface to work
                    [_curator] remoteExecCall ["training_fnc_neuterCurator", 2];
                    openCuratorInterface;
                    // Wait until no longer unconcsious or is dead, then cancel spectate
                    waitUntil {sleep 1; !(player getVariable ["ACE_isUnconscious", false]) or !(alive player)};
                    findDisplay 312 closeDisplay 2;
                    [_curator] remoteExecCall ["training_fnc_unsetCurator", 2];
                };
            };
        };

    };

};
