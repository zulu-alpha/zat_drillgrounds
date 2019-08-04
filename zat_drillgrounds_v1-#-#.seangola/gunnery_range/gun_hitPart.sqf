//diag_log format ["hitPart.sqf -> _this: %1", _this];
//diag_log format ["hitPart.sqf -> _target: %1", (_this select 0) select 0];

((_this select 0) select 0) setVariable ["hitPart", _this select 0, true];