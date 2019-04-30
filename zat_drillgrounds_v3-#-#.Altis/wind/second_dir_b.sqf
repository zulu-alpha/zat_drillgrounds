_pole = _this select 0;
_action_trash = (_this select 3) select 0;
_str = (_this select 3) select 1;
_deg = (_this select 3) select 2;

{
	_pole removeAction _x;
}foreach _action_trash;

_next_script = "wind\second_dir_c.sqf"

hint format ["
Wind strength: %1m
\nWind Bearing so far: %2deg
\n
\nSelect the second digit of your wind bearing.", _str, _deg];

_action_trash = [];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("0") + "</t>"),_next_script, [_action_trash,_str,0]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("1") + "</t>"),_next_script, [_action_trash,_str,100]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("2") + "</t>"),_next_script, [_action_trash,_str,200]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#fadfbe"">" + ("3") + "</t>"),_next_script, [_action_trash,_str,300]];
_action_trash set [count _action_trash, _action];

_action = _pole addAction[("<t color=""#FF0000"">" + ("Cancel") + "</t>"),"halo\cancel.sqf", [_action_trash]];
_action_trash set [count _action_trash, _action];