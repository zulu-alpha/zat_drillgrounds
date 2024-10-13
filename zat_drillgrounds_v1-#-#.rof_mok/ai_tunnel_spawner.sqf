/*
	Author: Phoenix

	Description: Turn an object into a tunnel entrance that will spawn one random AI at a
	time.
	The system can be enabled or disabled globally by setting the global variable
	`AI_TUNNEL_SPAWN_ENABLED` to false.

	Each tunnel entrance can be disabled individually with an addaction.

	Params:
	  0: OBJECT - Tunnel entrance.
	  1: NUMBER - Minimum distance in meters a player must be from the tunnel entrance for an AI to spawn.
	  2: NUMBER - How long it takes for an AI to spawn in seconds.

	Usage: nul = [this, 20, 10] execVM "ai_tunnel_spawner.sqf";
*/

if (isNil "AI_TUNNEL_SPAWNER_MAN_CLASSES") then {
	AI_TUNNEL_SPAWNER_MAN_CLASSES = [
		"O_G_Soldier_AR_F",
		"O_G_Soldier_GL_F",
		"O_G_Soldier_M_F",
		"O_G_Soldier_F",
		"O_G_Soldier_LAT_F"
	];
};

if (isNil "AI_TUNNEL_SPAWN_ENABLED") then {
	AI_TUNNEL_SPAWN_ENABLED = false;
};


params ["_tunnelEntrance", "_minDistance", "_spawnTime"];

_tunnelEntrance addaction [
	"Disable tunnel",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_target setVariable ["disabled_entrance", true, true];
	}, 
	nil,
	1.5,
	true,
	true,
	"",
	"!(_target getVariable ['disabled_entrance', false])",
	2
];
_tunnelEntrance addaction [
	"Enable tunnel",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		_target setVariable ["disabled_entrance", false, true];
	}, 
	nil,
	1.5,
	true,
	true,
	"",
	"_target getVariable ['disabled_entrance', false]",
	2
];

if !(isServer) exitWith {};

_this spawn {
	params ["_tunnelEntrance", "_minDistance", "_spawnTime"];
	while {sleep _spawnTime; true} do {
		private _spawned_ai = _tunnelEntrance getVariable ["spawned_ai", objNull];
		if (AI_TUNNEL_SPAWN_ENABLED == false) then {
			if !(isNull _spawned_ai) then {
				deleteVehicle _spawned_ai;
			};
			continue;
		};
		private _disabled_entrance = _tunnelEntrance getVariable ["disabled_entrance", false];
		if (_disabled_entrance) then {
			continue;
		};
		if (!(isNull _spawned_ai) and {alive _spawned_ai}) then {
			continue;
		};
		if ({(_tunnelEntrance distance _x) < _minDistance} count allPlayers > 0) then {
			continue;
		};

		private _pos = getPosATL _tunnelEntrance;
		private _dir = getDir _tunnelEntrance;
		private _class = selectRandom AI_TUNNEL_SPAWNER_MAN_CLASSES;
		private _group = createGroup [EAST, true];
		private _man = _group createUnit [_class, [0,0,0], [], 0, "None"];
		_man setPosATL _pos;
		_man setFormDir _dir;
		_man setDir _dir;
		_group setBehaviour "COMBAT";
		_tunnelEntrance setVariable ["spawned_ai", _man, true];
	};
};
