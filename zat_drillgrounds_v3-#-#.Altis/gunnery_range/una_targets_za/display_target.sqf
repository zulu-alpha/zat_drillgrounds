params ["_lane", "_scoretable", "_last_hit_pos"];

_display_target_mode = _lane getVariable ['display_target_mode', ['Large', 0.5]];


//Summary
_scorelist = [];
_totalscore = 0;
_i = 0;
while {(2 * _i) < count _scoretable} do {

    _xb =  _scoretable select (2 * _i);
    _yb =  _scoretable select (2 * _i + 1);

    _hit_distance_from_center = sqrt(_xb*_xb + _yb*_yb);

    _j = 0;
    while {_hit_distance_from_center < (UNA_TARGET_BORDERS select _j)} do {
    _j= _j + 1;
    };
    _score = _j;

    _scorelist = _scorelist + [_score];
    _totalscore = _totalscore + _score;

    _i = _i + 1;
};

//diag_log format ["_target: %1", _target];

_h_0_8 = 0; _h_1_8 = 0; _h_2_8 = 0; _h_3_8 = 0; _h_4_8 = 0; _h_5_8 = 0; _h_6_8 = "|"; _h_7_8 = 0; _h_8_8 = 0; _h_9_8 = 0; _h_10_8 = 0; _h_11_8 = 0; _h_12_8 = 0;
_h_0_7 = 0; _h_1_7 = 0; _h_2_7 = 0; _h_3_7 = 0; _h_4_7 = 0; _h_5_7 = 0; _h_6_7 = "|"; _h_7_7 = 0; _h_8_7 = 0; _h_9_7 = 0; _h_10_7 = 0; _h_11_7 = 0; _h_12_7 = 0;
_h_0_6 = 0; _h_1_6 = 0; _h_2_6 = 0; _h_3_6 = 0; _h_4_6 = 0; _h_5_6 = 0; _h_6_6 = "|"; _h_7_6 = 0; _h_8_6 = 0; _h_9_6 = 0; _h_10_6 = 0; _h_11_6 = 0; _h_12_6 = 0;
_h_0_5 = 0; _h_1_5 = 0; _h_2_5 = 0; _h_3_5 = 0; _h_4_5 = 0; _h_5_5 = 0; _h_6_5 = "|"; _h_7_5 = 0; _h_8_5 = 0; _h_9_5 = 0; _h_10_5 = 0; _h_11_5 = 0; _h_12_5 = 0;
_h_0_4 = "="; _h_1_4 = "="; _h_2_4 = "="; _h_3_4 = "="; _h_4_4 = "="; _h_5_4 = "="; _h_6_4 = 0; _h_7_4 = "="; _h_8_4 = "="; _h_9_4 = "="; _h_10_4 = "="; _h_11_4 = "="; _h_12_4 = "=";
_h_0_3 = 0; _h_1_3 = 0; _h_2_3 = 0; _h_3_3 = 0; _h_4_3 = 0; _h_5_3 = 0; _h_6_3 = "|"; _h_7_3 = 0; _h_8_3 = 0; _h_9_3 = 0; _h_10_3 = 0; _h_11_3 = 0; _h_12_3 = 0;
_h_0_2 = 0; _h_1_2 = 0; _h_2_2 = 0; _h_3_2 = 0; _h_4_2 = 0; _h_5_2 = 0; _h_6_2 = "|"; _h_7_2 = 0; _h_8_2 = 0; _h_9_2 = 0; _h_10_2 = 0; _h_11_2 = 0; _h_12_2 = 0;
_h_0_1 = 0; _h_1_1 = 0; _h_2_1 = 0; _h_3_1 = 0; _h_4_1 = 0; _h_5_1 = 0; _h_6_1 = "|"; _h_7_1 = 0; _h_8_1 = 0; _h_9_1 = 0; _h_10_1 = 0; _h_11_1 = 0; _h_12_1 = 0;
_h_0_0 = 0; _h_1_0 = 0; _h_2_0 = 0; _h_3_0 = 0; _h_4_0 = 0; _h_5_0 = 0; _h_6_0 = "|"; _h_7_0 = 0; _h_8_0 = 0; _h_9_0 = 0; _h_10_0 = 0; _h_11_0 = 0; _h_12_0 = 0;

private ["_h_99_99"]; //incase of none

_x_dimension = 12;
_y_dimension = 8;

//_border = UNA_TARGET_BORDERS select 0;
_border = _display_target_mode select 1;
_range = _border * 2;

_x_span = _range / _x_dimension;
_y_span = _range / _y_dimension;

_x_values = [];
_y_values = [];

for [{_i=0},{_i<=_x_dimension},{_i=_i+1}] do {
	_x_values = _x_values + [(-_border + (_i * _x_span))];
};

for [{_i=0},{_i<=_y_dimension},{_i=_i+1}] do {
	_y_values = _y_values + [(-_border + (_i * _y_span))];
};

_x_last_hit_pos = _last_hit_pos select 0;
_y_last_hit_pos = _last_hit_pos select 1;

_x_n = 99;
_y_n = 99;

private ["_x_n","_y_n"];

if !( (_x_last_hit_pos < ( (_x_values select 0) - (_x_span / 2) ) ) || (_x_last_hit_pos >= ( (_x_values select (_x_dimension)) + (_x_span / 2) ) ) || (_y_last_hit_pos < ( (_y_values select 0) - (_y_span / 2) ) ) || (_y_last_hit_pos >= ( (_y_values select (_y_dimension)) + (_y_span / 2) ) ) ) then {

    _i = 0;
    While {_i != _x_n} do {

    if ( ( ((_x_values select _i) - (_x_span / 2) ) <= _x_last_hit_pos ) && (_x_last_hit_pos < ((_x_values select _i) + (_x_span / 2) ) ) ) then {
            _x_n = _i;
            //hint "X in range";
        } else {
            _i = _i + 1;
        };

    };

    _i = 0;
    While {_i != _y_n} do {

    if ( ( ((_y_values select _i) - (_y_span / 2) ) <= _y_last_hit_pos ) && (_y_last_hit_pos < ((_y_values select _i) + (_y_span / 2) ) ) ) then {
            _y_n = _i;
            //hint "Y in range";
        } else {
            _i = _i + 1;
        };

    };


};

_hit_symbol = "<t color='#FF0000'>X</t>";
Call Compile Format["_h_%1_%2 = _hit_symbol",_x_n,_y_n,_hit_symbol];


hintSilent parseText format
["<t size='0.9' align='center'>%3 %4 %5 %6 %7 %8 %9 %10 %11 %12 %13 %14 %15
<br/>%16 %17 %18 %19 %20 %21 %22 %23 %24 %25 %26 %27 %28
<br/>%29 %30 %31 %32 %33 %34 %35 %36 %37 %38 %39 %40 %41
<br/>%42 %43 %44 %45 %46 %47 %48 %49 %50 %51 %52 %53 %54
<br/>%55 %56 %57 %58 %59 %60 %61 %62 %63 %64 %65 %66 %67
<br/>%68 %69 %70 %71 %72 %73 %74 %75 %76 %77 %78 %79 %80
<br/>%81 %82 %83 %84 %85 %86 %87 %88 %89 %90 %91 %92 %93
<br/>%94 %95 %96 %97 %98 %99 %100 %101 %102 %103 %104 %105 %106
<br/>%107 %108 %109 %110 %111 %112 %113 %114 %115 %116 %117 %118 %119</t>
<br/>
<br/><t color='#FF0000'> Display mode: %2</t>
<br/>
<br/><t align='center'>Scores:</t>
<br/><t size='0.9' align='center'>%1</t>
<br/><t align='center'>Hits:</t>
<br/><t size='0.9' align='center'>%120</t>
<br/><t align='center'>Total Score:</t>
<br/><t size='0.9' align='center'>%121</t>
",_scorelist,_display_target_mode select 0
,_h_0_8,_h_1_8,_h_2_8,_h_3_8,_h_4_8,_h_5_8,_h_6_8,_h_7_8,_h_8_8,_h_9_8,_h_10_8,_h_11_8,_h_12_8
,_h_0_7,_h_1_7,_h_2_7,_h_3_7,_h_4_7,_h_5_7,_h_6_7,_h_7_7,_h_8_7,_h_9_7,_h_10_7,_h_11_7,_h_12_7
,_h_0_6,_h_1_6,_h_2_6,_h_3_6,_h_4_6,_h_5_6,_h_6_6,_h_7_6,_h_8_6,_h_9_6,_h_10_6,_h_11_6,_h_12_6
,_h_0_5,_h_1_5,_h_2_5,_h_3_5,_h_4_5,_h_5_5,_h_6_5,_h_7_5,_h_8_5,_h_9_5,_h_10_5,_h_11_5,_h_12_5
,_h_0_4,_h_1_4,_h_2_4,_h_3_4,_h_4_4,_h_5_4,_h_6_4,_h_7_4,_h_8_4,_h_9_4,_h_10_4,_h_11_4,_h_12_4
,_h_0_3,_h_1_3,_h_2_3,_h_3_3,_h_4_3,_h_5_3,_h_6_3,_h_7_3,_h_8_3,_h_9_3,_h_10_3,_h_11_3,_h_12_3
,_h_0_2,_h_1_2,_h_2_2,_h_3_2,_h_4_2,_h_5_2,_h_6_2,_h_7_2,_h_8_2,_h_9_2,_h_10_2,_h_11_2,_h_12_2
,_h_0_1,_h_1_1,_h_2_1,_h_3_1,_h_4_1,_h_5_1,_h_6_1,_h_7_1,_h_8_1,_h_9_1,_h_10_1,_h_11_1,_h_12_1
,_h_0_0,_h_1_0,_h_2_0,_h_3_0,_h_4_0,_h_5_0,_h_6_0,_h_7_0,_h_8_0,_h_9_0,_h_10_0,_h_11_0,_h_12_0,
count _scorelist,_totalscore
];