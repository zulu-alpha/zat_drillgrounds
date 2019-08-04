_pole = _this select 0;
_action_trash = (_this select 3) select 0;
_alt = (_this select 3) select 1;
_vel = (_this select 3) select 2;
_deg = (_this select 3) select 3;

{
	_pole removeAction _x;
}foreach _action_trash;

hint format ["
Jump Altitude: %1m
\nHorizontal Jump Velocity: %2m/s
\nJump Bearing so far: %3deg
\n
\nSelect the final digit of your jump bearing.", _alt, _vel, _deg];

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("0") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,0 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("1") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,1 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("2") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,2 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("3") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,3 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("4") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,4 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("5") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,5 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("6") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,6 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("7") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,7 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("8") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,8 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("9") + "</t>"),"halo\fourth_pos.sqf", [_action_trash,_alt,_vel,9 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#FF0000"">" + ("Cancel") + "</t>"),"halo\cancel.sqf", [_action_trash]];
_action_trash set [count _action_trash, _action];