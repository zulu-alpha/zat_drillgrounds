//=====================================================================
//script by Walker
//www.united-nations-army.eu
//=====================================================================
// This script initilizes a new target, collects the positions of the hits.
// The saved positions are passed to check_target.sqf
// Init line: nul = [this] execVM "una_targets\init_target.sqf";
//=====================================================================


_path = "gunnery_range\una_targets_za\";
_lane = _this select 0;
private ["_target"];
_target = _lane getVariable ['target', ObjNull];
_target allowDamage False;
_scoretable = [];
_target setVariable ['scoretable', _scoretable, true];
_last_hit_pos = [];


_target setVectorUp [0,0,1];

//-----------------------------------------------
//Initilize target
//-----------------------------------------------

//set target texture
_target setObjectTextureGlobal [0,_path + 'circular_target.paa'];
//this setObjectTexture [0,"gunnery_range\una_targets_za\" + 'circular_target.paa'];

WALK_TARGET_PUBVAR = _target;

//get target center position
_offset =[0.00,-1.306];

//calibrated score borders
_borders = [0.460,0.410,0.365,0.320,0.270,0.225,0.175,0.130,0.080,0.035, 0];
_holelist = [];
_score_table_count_before = 0;
_action_cs = 1000;
_action_ct = 1000;

//how often the the target is checked for new hits (in seconds)
_sweeptime = 0.1;

//-----------------------------------------------
//target loop
//-----------------------------------------------
_xb = 0;
_yb = 0;

While {!(isNil '_target') && {!(isNull _target)}} do {

  _scoretable = _target getVariable ['scoretable', []];

  //if there has been new hits to the target -> update check target actions
  if(count _scoretable > _score_table_count_before) then {

    _score_table_count_before = count _scoretable;

    [_lane,_scoretable,_last_hit_pos] execVM _path + "display_target.sqf";


  }
  else {
    _score_table_count_before = count _scoretable;
  };

  //if target has been cleared
  if (WALK_TARGET_PUBVAR == _lane) then {
          _scoretable = [];
          _target setVariable ['scoretable', _scoretable, true];
          WALK_TARGET_PUBVAR = _target;
          publicVariable "WALK_TARGET_PUBVAR";
  };


  //wait sweeptime
  sleep _sweeptime;


  //get recent hits
  _hits = [(getposATL _target select 0),(getposATL _target select 1),(getposATL _target select 2) -  (_offset select 1)] nearObjects ["#craterOnVehicle",1];

    if(count _hits > 0) then {

      _last_hit = _hits select (count _hits - 1);


        _j = 0;
        //iteratet trough all hits since last sweep
        while { !(_last_hit in _holelist) } do {

          _holelist = _holelist + [_last_hit];

          //position of last hit (in world coords)
          _xh = getpos _last_hit select 0;
          _yh = getpos _last_hit select 1;
          _zh = getpos _last_hit select 2;

          //position of target (in world coords)
          _xt = getposATL _target select 0;
          _yt = getposATL _target select 1;
          _zt = getposATL _target select 2;

          //position of last hit (in target coords)
          _xb = sqrt((_xh-_xt)*(_xh-_xt) + (_yh-_yt)*(_yh-_yt)) + (_offset select 0);
          _yb = _zh + (_offset select 1);


          if (_xh < _xt) then {
            _xb = -_xb;
          };
          if ((getdir _target) >= 180) then {
             _xb = -_xb;
          };

          //save the hit positions into an array
          _scoretable = _scoretable + [_xb,_yb];
          _target setVariable ['scoretable', _scoretable, true];
          _last_hit_pos = [_xb,_yb];

          _j = _j + 1;

          if (count _hits > (_j)) then {
               _last_hit = _hits select (count _hits - (_j + 1));
          };

        };

      };
};