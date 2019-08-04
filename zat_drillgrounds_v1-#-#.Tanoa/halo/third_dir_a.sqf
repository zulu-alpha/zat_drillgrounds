_pole = _this select 0;
_action_trash = (_this select 3) select 0;
_alt = (_this select 3) select 1;
_vel = (_this select 3) select 2;

{
	_pole removeAction _x;
}foreach _action_trash;

hint format ["
Jump Altitude: %1m
\nHorizontal Jump Velocity: %2m/s
\n
\nSelect the first digit of your jump bearing.", _alt, _vel];

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("0") + "</t>"),"halo\third_dir_b.sqf", [_action_trash,_alt,_vel,0]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("1") + "</t>"),"halo\third_dir_b.sqf", [_action_trash,_alt,_vel,100]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("2") + "</t>"),"halo\third_dir_b.sqf", [_action_trash,_alt,_vel,200]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("3") + "</t>"),"halo\third_dir_b.sqf", [_action_trash,_alt,_vel,300]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#FF0000"">" + ("Cancel") + "</t>"),"halo\cancel.sqf", [_action_trash]];
_action_trash set [count _action_trash, _action];