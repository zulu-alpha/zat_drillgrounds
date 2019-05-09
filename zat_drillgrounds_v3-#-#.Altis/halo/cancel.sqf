_pole = _this select 0;
_action_trash = (_this select 3) select 0;

{
	_pole removeAction _x;
}foreach _action_trash;

_pole addAction [("<t color=""#fadfbe"">" + ("Configure new jump") + "</t>"),"halo\first_alt.sqf"];

hint "Jump cancelled";