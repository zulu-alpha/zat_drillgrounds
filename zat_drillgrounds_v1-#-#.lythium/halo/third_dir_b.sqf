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
\nSelect the second digit of your jump bearing.", _alt, _vel, _deg];

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("0") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,0 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("1") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,10 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("2") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,20 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("3") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,30 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("4") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,40 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("5") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,50 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("6") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,60 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("7") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,70 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("8") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,80 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("9") + "</t>"),"halo\third_dir_c.sqf", [_action_trash,_alt,_vel,90 + _deg]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#FF0000"">" + ("Cancel") + "</t>"),"halo\cancel.sqf", [_action_trash]];
_action_trash set [count _action_trash, _action];