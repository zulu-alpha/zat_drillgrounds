_pole = _this select 0;
_action_old = _this select 2;

_pole removeAction _action_old;

hint "Select your jump altitude";

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("100m") + "</t>"),"halo\second_vel.sqf", [_action_trash,100]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("250m") + "</t>"),"halo\second_vel.sqf", [_action_trash,250]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("500m") + "</t>"),"halo\second_vel.sqf", [_action_trash,500]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("750m") + "</t>"),"halo\second_vel.sqf", [_action_trash,750]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("1000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,1000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("1500m") + "</t>"),"halo\second_vel.sqf", [_action_trash,1500]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("2000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,2000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("3000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,3000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("4000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,4000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("5000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,5000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("6000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,6000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("7000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,7000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("8000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,8000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("9000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,9000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("10000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,10000]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("11000m") + "</t>"),"halo\second_vel.sqf", [_action_trash,11000]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#FF0000"">" + ("Cancel") + "</t>"),"halo\cancel.sqf", [_action_trash]];
_action_trash set [count _action_trash, _action];