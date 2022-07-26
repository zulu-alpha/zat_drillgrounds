/*
    Description: 
	Creates the root addaction menu items for the client and cleans old menu items if provided.

    Params:
    0: OBJECT - Object to add addaction menu items to
    1: ARRAY - of addaction NUMBERs to remove

    Returns:
	None
*/
params ["_course", "_old_action_trash"];

// Clean old action menu items
{
    _course removeAction _x;
} count _old_action_trash;

private _is_not_active = "!(_target getVariable ['groundControl_isActive', false])";
private _is_active = "_target getVariable ['groundControl_isActive', false]";

private _action_trash = [];

_action = _course addAction [
    ("<t color=""#FFBF00"">" + ("Start round") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target] remoteExec ["groundControl_fnc_startRound", 2];
    },
    [],
    1.5,
    true,
    true,
    "",
    _is_not_active
];
_action_trash pushBack _action;


_action = _course addAction [
    ("<t color=""#FFBF00"">" + ("End round") + "</t>"),
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target] remoteExec ["groundControl_fnc_endRound", 2];
    },
    [],
    1.5,
    true,
    true,
    "",
    _is_active
];
_action_trash pushBack _action;
