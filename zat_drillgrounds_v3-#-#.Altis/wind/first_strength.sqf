_pole = _this select 0;
_action_old = _this select 2;

_pole removeAction _action_old;

hint "Select your wind strength";

_next_script = "wind\second_dir_a.sqf"

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("0 m/s") + "</t>"),_next_script, [_action_trash,0]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("1 m/s") + "</t>"),_next_script, [_action_trash,1]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("2 m/s") + "</t>"),_next_script, [_action_trash,2]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("3 m/s") + "</t>"),_next_script, [_action_trash,3]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("4 m/s") + "</t>"),_next_script, [_action_trash,4]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("5 m/s") + "</t>"),_next_script, [_action_trash,5]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("6 m/s") + "</t>"),_next_script, [_action_trash,6]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("7 m/s") + "</t>"),_next_script, [_action_trash,7]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("8 m/s") + "</t>"),_next_script, [_action_trash,8]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("9 m/s") + "</t>"),_next_script, [_action_trash,9]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("10 m/s") + "</t>"),_next_script, [_action_trash,10]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("11 m/s") + "</t>"),_next_script, [_action_trash,11]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("12 m/s") + "</t>"),_next_script, [_action_trash,12]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("13 m/s") + "</t>"),_next_script, [_action_trash,13]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("14 m/s") + "</t>"),_next_script, [_action_trash,14]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("15 m/s") + "</t>"),_next_script, [_action_trash,15]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("16 m/s") + "</t>"),_next_script, [_action_trash,16]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("17 m/s") + "</t>"),_next_script, [_action_trash,17]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("18 m/s") + "</t>"),_next_script, [_action_trash,18]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("19 m/s") + "</t>"),_next_script, [_action_trash,19]];
_action_trash set [count _action_trash, _action];
_action = _pole addAction[("<t color=""#fadfbe"">" + ("20 m/s") + "</t>"),_next_script, [_action_trash,20]];
_action_trash set [count _action_trash, _action];


_action = _pole addAction[("<t color=""#FF0000"">" + ("Cancel") + "</t>"),"wind\cancel.sqf", [_action_trash]];
_action_trash set [count _action_trash, _action];