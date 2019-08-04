_player = (_this select 3) select 0;

// Determine whether to hide or reveal player (opposite of current state)
_bool = !(isObjectHidden _player);

// Set unit to oppos
[_player, _bool] remoteExecCall ["hideObjectGlobal", 2];

// Hint it
hint format ["Hidden: %1", _bool];
