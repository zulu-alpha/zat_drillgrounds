_lane = _this select 3;

_target = _lane getVariable ["target", ObjNull];

_target setVariable ["scoretable", [], true];
hintSilent "Target cleared";
