/*
    Description:
	Determine the ownership of the given marker area and change it's color accordingly.

    Params:
    0: STRING - Marker name of area marker.

    Returns: SIDE - west, east for enemy, sideUnknown for contested and sideEmpty for no
	                ownership.
*/
params ["_marker_name"];

private _west_count = [_marker_name, west] call groundControl_fnc_getAreaSideStrength;
private _east_count = [_marker_name, east] call groundControl_fnc_getAreaSideStrength;

private _ownership = sideEmpty;

// West ownership
if ((_west_count > 0) and (_east_count == 0)) then {
    _marker_name setMarkerColor "colorBLUFOR";
    _ownership = west;
};

// East ownership
if ((_west_count == 0) and (_east_count > 0)) then {
    _marker_name setMarkerColor "colorOPFOR";
    _ownership = east;
};

// Contested ownership
if ((_west_count > 0) and (_east_count > 0)) then {
    _marker_name setMarkerColor "ColorUNKNOWN";
    _ownership = sideUnknown;
};

// Empty (no ownership)
if ((_west_count == 0) and (_east_count == 0)) then {
    _marker_name setMarkerColor "ColorBlack";
    _ownership = sideEmpty;
};

_ownership