/*
	Description:
	Uses the given area marker to detect strength of a particular side

	Parameter(s):
	0: STRING - Marker name of area marker.
	1: SIDE - Side to get the strength for.

	Returns:
	NUMBER
*/
params ["_marker_name", "_side"];

{(side _x == _side)} count (allUnits inAreaArray _marker_name)