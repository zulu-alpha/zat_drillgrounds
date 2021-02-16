// Wait until in an unconscious state then start spectator and exit when no longer in one and alive.
// Ace fnc returns true if unconcsious

// Only execute once
if !(isNil "training_var_spect_uncon") exitWith {};
training_var_spect_uncon = true;

spect_uncon_original_side = side player;

if !(hasInterface) exitWith{};
waitUntil {!(isNull player)};

[[0,2,3], []] call ace_spectator_fnc_updateCameraModes;
[[-2,-1,0], []] call ace_spectator_fnc_updateVisionModes;

[] spawn {

    while {sleep 3; true} do {

        // If unconcsious, spectate
        if (player getVariable ["ACE_isUnconscious", false] and (alive player)) then {
            // Delay to make sure stay unconscious for long enough and if still unconscious, continue
            sleep 13;
            if (player getVariable ["ACE_isUnconscious", false] and (alive player)) then {
                private _same_side_players = [];
                private _units = if (!isMultiplayer) then {switchableUnits} else {playableUnits};
                // Done here for JiP Players
                {
                    if (side _x == spect_uncon_original_side) then {
                        _same_side_players pushBack _x;
                    };
                } forEach _units;
                [_same_side_players, [player]] call ace_spectator_fnc_updateUnits;
                [true, false, false] call ace_spectator_fnc_setSpectator;
                // Wait until no longer unconcsious or is dead, then cancel spectate
                waitUntil {sleep 1; !(player getVariable ["ACE_isUnconscious", false]) or !(alive player)};
                [false] call ace_spectator_fnc_setSpectator;
            };
        };

    };

};
