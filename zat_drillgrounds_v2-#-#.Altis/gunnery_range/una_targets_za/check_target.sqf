_lane = _this select 3;
_target = _lane getVariable['target',objNull];

_scoretable = _target getVariable ['scoretable', []];

_borders = [0.460,0.410,0.365,0.320,0.270,0.225,0.175,0.130,0.080,0.035, 0];
_scorelist = [];
_totalscore = 0;
_i = 0;
while {(2 * _i) < count _scoretable} do {

    _xb =  _scoretable select (2 * _i);
    _yb =  _scoretable select (2 * _i + 1);

    _hit_distance_from_center = sqrt(_xb*_xb + _yb*_yb);

    _j = 0;
    while {_hit_distance_from_center < (_borders select _j)} do {
    _j= _j + 1;
    };
    _score = _j;

    _scorelist = _scorelist + [_score];
    _totalscore = _totalscore + _score;

    _i = _i + 1;


};

/*
_zero = {_x==0} count _scorelist;
_one = {_x==1} count _scorelist;
_two = {_x==2} count _scorelist;
_three = {_x==1} count _scorelist;
_four = {_x==2} count _scorelist;
_five = {_x==1} count _scorelist;
_six = {_x==2} count _scorelist;
_seven = {_x==1} count _scorelist;
_eight = {_x==2} count _scorelist;
_nine = {_x==1} count _scorelist;
_ten = {_x==2} count _scorelist;

Score|Times
-----|------
 10  |  2
  8  |  2
  7  |  2
  6  |  2
  5  |  2
  4  |  2
  3  |  2
  2  |  2
  1  |  2
  0  |  2
-----------
     | 20

 */

hintSilent format["You've hit the target %3 times:\n\n %1 \n\n Total score: %2\n",_scorelist,_totalscore, count _scorelist];
