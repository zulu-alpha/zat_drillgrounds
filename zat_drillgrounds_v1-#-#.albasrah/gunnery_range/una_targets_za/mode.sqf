_lane = (_this select 3) select 0;

private ["_name","_number"];
_name = (_lane getVariable ['display_target_mode', ['Large', 0.5]]) select 0;

switch (_name) do {

	case "Large": {
		_name = "Wookiee";
		_number = 0.175;
	};

	case "Wookiee": {
		_name = "Large";
		_number = 0.5;
	};
};

hintSilent format ["%1 mode",_name];

_lane setVariable ['display_target_mode', [_name,_number], true];