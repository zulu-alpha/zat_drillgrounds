_pole = _this select 0;
_action_trash = (_this select 3) select 0;
_alt = (_this select 3) select 1;

{
	_pole removeAction _x;
}foreach _action_trash;

hint format ["
Jump Altitude: %1m
\n
\nSelect your horizontal jump velocity.", _alt];

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("0m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,0]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("5m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,5]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("10m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,10]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("20m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,20]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("30m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,30]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("40m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,40]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("50m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,50]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("75m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,75]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("100m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,100]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("150m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,150]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("200m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,200]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("250m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,250]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("300m/s") + "</t>"),"halo\third_dir_a.sqf", [_action_trash,_alt,300]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#FF0000"">" + ("Cancel") + "</t>"),"halo\cancel.sqf", [_action_trash]];
_action_trash set [count _action_trash, _action];