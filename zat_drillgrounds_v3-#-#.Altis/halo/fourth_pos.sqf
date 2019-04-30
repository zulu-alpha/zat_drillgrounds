_pole = _this select 0;
_action_trash = (_this select 3) select 0;
_alt = (_this select 3) select 1;
_vel = (_this select 3) select 2;
_deg = (_this select 3) select 3;

{
	_pole removeAction _x;
}foreach _action_trash;

halo_vel_cart = [_vel*(sin _deg), _vel*(cos _deg), 0];
diag_log format["halo_vel_cart: %1", halo_vel_cart];
halo_altitude = _alt;
halo_dir = _deg;

haloed = true;

hint format ["
Jump Altitude: %1m
\nHorizontal Jump Velocity: %2m/s
\nJump Bearing: %3 deg
\n
\nClick on the map where you'd like to HALO.", _alt,_vel,_deg];

onMapSingleClick "player setPos [_pos select 0, _pos select 1, halo_altitude]; player setdir halo_dir; player setVelocity halo_vel_cart; haloed = false; hint 'Close your map now, and good luck.'";
waitUntil{!haloed};
onMapSingleClick "";

sleep 5;
_pole execVM "halo\init.sqf";