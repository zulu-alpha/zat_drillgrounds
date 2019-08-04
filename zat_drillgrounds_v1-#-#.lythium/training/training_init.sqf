_ds = _this;

// time to initialize
waituntil {time > 1};

// Make DS invulnereble
_ds allowDamage False;

// Only run on DS client
if isDedicated exitWith {};
waituntil {player == player};
if !(local _ds) exitWith {};

// Actually give all the addactions
[_ds,"","",[[]]] execVM "training\training_start.sqf";
["AmmoboxInit", [_ds, true, {_target == _this}]] spawn BIS_fnc_arsenal;

// Track all units
[] execVM "training\training_track.sqf";
