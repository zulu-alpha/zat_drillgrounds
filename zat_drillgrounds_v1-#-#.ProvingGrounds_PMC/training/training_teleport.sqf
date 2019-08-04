_pole = _this select 0;
_action_trash = (_this select 3) select 0;

{
	_pole removeAction _x;
}foreach _action_trash;

hint "Click on a point on the map to move the destination teleporter there.";

onMapSingleClick format ["

%1 setPos _pos; %1 setVectorDirAndUp [[1,0,0],[1,0,1]];

hint ""Teleporter Position set""

",training_teleporter];

_action = _pole addAction[("<t color=""#ff8a00"">" + ("Back") + "</t>"),"training\training_start.sqf", [_action_trash],6];
_action_trash set [count _action_trash, _action];