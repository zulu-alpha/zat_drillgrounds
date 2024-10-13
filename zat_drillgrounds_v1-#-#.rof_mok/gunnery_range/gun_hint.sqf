if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_hint.sqf started"};

private ["_lane"];

if (zam_gun_var_hintOn) then {
	zam_gun_var_hintOn = false;
	sleep 1;
};

zam_gun_var_hintOn = true;

_lane = (_this select 3) select 0;

while {zam_gun_var_hintOn} do {

	private ["_target", "_target_hint", "_hitPart"];

	_target = _lane getVariable ["target", objNull];
	if (typeOf _target == "WarfareBunkerSign") exitWith {};
	_target_hint = _lane getVariable ["target_hint", ""];
	_hitPart = _target getVariable ["hitPart",[_target,"N\A","N\A","N\A",[0,0,0],"N\A","N\A","N\A","N\A","N\A","N\A"]];


	hintSilent parseText format [_target_hint,
	"%",                                            //1
	typeOf _target,                                 //2
	round (_target distance player),                //3
	round ( (damage _target) * 100 ),               //4
	alive _target,                                  //5
	canStand _target,                               //6
	round ( (damage (driver _target)) * 100 ),      //7
	alive (driver _target),                         //8
	round ( (damage (gunner _target)) * 100 ),      //9
	alive (gunner _target),                         //10
	round ( (damage (commander _target)) * 100 ),   //11
	alive (commander _target),                      //12
	canfire _target,                                //13
	someammo _target,                               //14
	canMove _target,                                //15
	round ( (fuel _target) * 100 ),                 //16
	round (sqrt ( ((_hitPart select 4) select 0)^2 + ((_hitPart select 4) select 1)^2 + ((_hitPart select 4) select 2)^2 )),  //17
	_hitPart select 10,                             //18
	_hitPart select 5,                              //19
	_hitPart select 9,                              //20
	_target KnowsAbout player                       //21
	];

	sleep 0.2;

};



if (!(isNil "zam_debug") && {zam_debug}) then {diag_log "gun_hint.sqf finished"};