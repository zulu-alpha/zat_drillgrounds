_lane = _this select 3;

//broadcast to clients that the target needs to be cleared
hintSilent "Target cleared";
WALK_TARGET_PUBVAR = _lane;
publicVariable "WALK_TARGET_PUBVAR";
