//=====================================================================
//script by Walker
//heavily modified by Phoenix of Zulu-Alpha
//www.united-nations-army.eu
//=====================================================================
// This script initilizes a new target, collects the positions of the hits.
// The saved positions are passed to check_target.sqf
// Init line: nul = [this] execVM "una_targets\init_target.sqf";
//=====================================================================


_path = "gunnery_range\una_targets_za\";
_lane = _this select 0;
private ["_target"];
_target = _lane getVariable ["target", ObjNull];
_target allowDamage False;
_target setVariable ["scoretable", [], true];
_target setVariable ["lane", _lane, true];
_target setVariable ["last_hit_pos", [], true];
UNA_TARGET_BORDERS = [0.460,0.410,0.365,0.320,0.270,0.225,0.175,0.130,0.080,0.035, 0];


_target setVectorUp [0,0,1];

//-----------------------------------------------
//Initilize target
//-----------------------------------------------

//set target texture
_target setObjectTextureGlobal [0,_path + "circular_target.paa"];
//this setObjectTexture [0,"gunnery_range\una_targets_za\" + 'circular_target.paa'];


//how often the the target is checked for new hits (in seconds)


//-----------------------------------------------
//Display loop
//-----------------------------------------------
[_target, _path] spawn {

  params ["_target", "_path"];
  _sweeptime = 0.1;
  _score_table_count_before = 0;

  While {!(isNil "_target") && {!(isNull _target)}} do {

    _scoretable = _target getVariable ["scoretable", []];
    _lane = _target getVariable ["lane", objNull];
    _last_hit_pos = _target getVariable ["last_hit_pos", []];

    //if there has been new hits to the target -> update check target actions
    if(count _scoretable > _score_table_count_before) then {

      _score_table_count_before = count _scoretable;

      [_lane,_scoretable,_last_hit_pos] execVM _path + "display_target.sqf";

    }
    else {
      _score_table_count_before = count _scoretable;
    };

    sleep _sweeptime;
  };

};

//hit function
fnc_una_hit = {
  params ["_target", "_hit_pos_asl"];

  _scoretable = _target getVariable ["scoretable", []];

  //get target center position
  _z_offset =-0.6;

  //get relevant parts of model to world
  _hit_pos_atl = ASLToATL _hit_pos_asl;
  _model_coords = _target worldToModelVisual _hit_pos_atl;
  _xb = _model_coords select 0;
  _yb = (_model_coords select 2) + _z_offset;

  //save the hit positions into an array
  _scoretable = _scoretable + [_xb,_yb];
  _target setVariable ["scoretable", _scoretable, true];
  _last_hit_pos = [_xb,_yb];
  _target setVariable ["last_hit_pos", _last_hit_pos, true];
};

_target addEventHandler ["HitPart", {[(_this select 0) select 0, (_this select 0) select 3] call fnc_una_hit}];
