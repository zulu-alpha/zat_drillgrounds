params ["_target", "_caller", "_actionId", "_arguments"];
_arguments params ["_action_trash", "_altitude", "_velocity", "_direction"];

{
	_target removeAction _x;
} foreach _action_trash;

halo_vel_cart = [_velocity * (sin _direction), _velocity * (cos _direction), 0];
diag_log format["halo_vel_cart: %1", halo_vel_cart];
halo_altitude = _altitude;
halo_dir = _direction;

hint format ["
	Altitude: %1m
	\nVelocity: %2m/s
	\nJump heading: %3deg
	\n
	\nClick on the map where you'd like to HALO.", 
	_altitude, _velocity, _direction
];

haloed = true;

onMapSingleClick "player setPos [_pos select 0, _pos select 1, halo_altitude]; player setdir halo_dir; player setVelocity halo_vel_cart; haloed = false; hint 'Close your map now, and good luck.'";
waitUntil{!haloed};
onMapSingleClick "";

sleep 5;
[_target] execVM "jump\init.sqf";
