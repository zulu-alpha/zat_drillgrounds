/*

    Author: Phoenix of Zulu-Alpha

    Description: Selects a random spawn position relative to the given object.

    Params:
        0: OBJECT - Relative spawn position.

    Returns: POSITION ATL

*/

params ["_refObject"];

private _deltaDistance = threeddrill_max_distance - threeddrill_min_distance;

private _distance = threeddrill_min_distance + (random _deltaDistance);
private _direction = random 360;
[getPosATL _refObject, _distance, _direction] call BIS_fnc_relPos