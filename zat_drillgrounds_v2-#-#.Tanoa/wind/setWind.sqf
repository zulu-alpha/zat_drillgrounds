/*
	Description:
	Sets the wind with the given direction and strength. 

	Parameter(s):
	0: NUMBER - Wind speed in m/s.
	1: NUMBER - Wind direction in degrees.

	Returns:
	Nothing
*/
if !(isServer) exitWith {};

_this spawn {
	params ["_strength", "_direction"];
	private _x_component = _strength * sin _direction;
	private _y_component = _strength * cos _direction;
	waitUntil {time > 3};  // Just to be safe.
	setWind [_x_component, _y_component, true];
	sleep 0.1;
	forceWeatherChange;
	sleep 0.1;
	simulWeatherSync;
};
