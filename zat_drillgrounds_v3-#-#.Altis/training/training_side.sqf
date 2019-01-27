_player = (_this select 3) select 0;

_old_side = side _player;
_old_group = group _player;

if (_old_side == west) then {
	[_player] joinSilent (createGroup resistance); 
};

if (_old_side == resistance) then {
	[_player] joinSilent (createGroup west); 
};

deleteGroup _old_group;
_new_side = side _player;

hint format ["Was %1. Now %2", _old_side, _new_side];
