if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_makeHint.sqf started"};

private ["_target", "_hint"];

_target = _this select 0;

// If BullsEye
if (typeOf _target == "WarfareBunkerSign") exitWith {''};

_hint = "<t align='center'>Target: <t color='#ffff00'>%2</t>
		 <br/>Distance: <t color='#ffff00'>%3m</t>
		 <br/>";

// Soldier
if (_target in crew _target) then {

_hint = _hint +
	   "<br/>Damage: <t color='#ffff00'>%4%1</t>
		<br/>Conscious: <t color='#ffff00'>%5</t>
		<br/>Can Stand: <t color='#ffff00'>%6</t>
		<br/>
		<br/>Impact Velocity: <t color='#ffff00'>%17m/s</t>
		<br/>Direct impact: <t color='#ffff00'>%18</t>
		<br/>Awareness of you: <t color='#ffff00'>%21</t>";

// Vehicle
} else {

	_hint = _hint +
	   	   "<br/>Vehicle Damage: <t color='#ffff00'>%4%1</t>";

	// Run if vehicle has crew (not a pop-up for eg.)
	if (count (crew _target) > 0) then {

		if (!isNull (driver _target)) then {
		_hint = _hint +
		   	  "<br/>Driver Damage: <t color='#ffff00'>%7%1</t>
			   <br/>Driver Conscious: <t color='#ffff00'>%8</t>";
		};

		if (!isNull (gunner _target)) then {
		_hint = _hint +
	 	  	  "<br/>Gunner Damage: <t color='#ffff00'>%9%1</t>
			   <br/>Gunner Conscious: <t color='#ffff00'>%10</t>";
		};

		if (!isNull (commander _target)) then {
		_hint = _hint +
	 	  	  "<br/>Commander Damage: <t color='#ffff00'>%11%1</t>
			   <br/>Commander Conscious: <t color='#ffff00'>%12</t>";
		};

		_hint = _hint +
		   "<br/>Can Fire: <t color='#ffff00'>%13</t>
			<br/>Has Ammo: <t color='#ffff00'>%14</t>
			<br/>Mobile: <t color='#ffff00'>%15</t>
			<br/>Fuel: <t color='#ffff00'>%16%1</t>
			<br/>
			<br/>Impact Velocity: <t color='#ffff00'>%17m/s</t>
			<br/>
			<br/>Direct impact: <t color='#ffff00'>%18</t>
			<br/>Part(s) hit: <t color='#ffff00'>%19</t>
			<br/>Surface type: <t color='#ffff00'>%20</t>
			<br/>
			<br/>Awareness of you: <t color='#ffff00'>%21</t>";
	};

};

// _percent, _target, _dist, _damage, alive _target, canStand _target, _damage_d, alive _driver, _damage_g, alive _gunner, _damage_c, alive _commander, canfire _target, someammo _target, canMove _target, _fuel, _vel, _hitpart select 10, _hitpart select 5, _hitpart select 9, _awar];
//        1,       2,     3,       4,             5,                6,         7,             8,         9,            10,        11,               12,              13,               14,              15,    16,   17,                 18,                19,                20,    21]

if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_makeHint.sqf finished"};

_hint