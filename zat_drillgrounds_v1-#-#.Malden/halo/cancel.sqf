_player = _this select 0;
_action_trash = (_this select 3) select 0;

{
	_player removeAction _x;
}foreach _action_trash;

_this addAction[("<t color=""#fadfbe"">" + ("Configure new jump") + "</t>"),"halo\first_alt.sqf"];

hint "Unit Creation Cancelled";