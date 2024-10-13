/*
    Description:
	Get an array of which of all the given areas belong to the given side.

    Params:
    0: SIDE - The side to filter for.
    1: ARRAY - Array of strings representing objective area markers.

    Returns: ARRAY
*/
params ["_side", "_objectives"];

private _areas_owned_by_side = [];

{
    private _actual_side = [_x] call groundControl_fnc_processObjectiveArea;  
    if (_actual_side == _side) then {
        _areas_owned_by_side pushBackUnique _x;
    };
} forEach _objectives;

_areas_owned_by_side