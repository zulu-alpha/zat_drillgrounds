/*
Author:
	Phoenix of Zulu-Alpha

Description:
	Make the given object a teleporter for a given side only, but only works if a the
	given hostile side is not within the given minimum distance, or if the teleporter is
	not disabled.
	A teleporter can only be disabled by anyone not on the friendly side.
	Also show the current location of the teleporter on the map for the given side.
	Each teleporter can be a source (has other teleporters as targets) or a sink (can 
	only be teleporterd to).
	Sources cannot be disabled.

Parameters:
	0: Object: The object to make a teleporter.
	1: String: Name of the teleporter.
	2: Side: The side that this teleporter belongs to.
	3: Bool: True if is source, false if is sink.
	4: Side (Optional): The side that this teleporter is hostile to.
		Necessary if is sink.
	5: Number (Optional): The minimum distance between the teleporter and the hostile side.
		Necessary if is sink.

Usage:
	Execute on each object to be used as a teleporter.

Example:
	For sources:
		[this, "Teleporter", independent, true] execVM "tvt_teleporter.sqf";
	For sinks:
		[this, "Destination 1", independent, false, west, 50] execVM "tvt_teleporter.sqf";
*/

params [
	"_teleporter",
	"_name",
	"_firendly_side",
	"_is_source"
];
private _hostile_side = if (count _this > 4) then {
	_this # 4
} else {
	sideUnknown
};
private _min_distance = if (count _this > 5) then {
	_this # 5
} else {
	-1
};
private _tracker_delay = 5;

private _is_sink = !(_is_source);
if (_is_sink and _hostile_side == sideUnknown) exitWith {
	systemChat ["Hostile side must be specified for sink %1!", _name];
};
if (_is_sink and _min_distance == -1) exitWith {
	systemChat ["Minimum distance must be specified for sink %1!", _name];
};

if !hasInterface exitWith {};
waitUntil {sleep 1; (!(isNull player)) and (time > 2)};

_teleporter setVariable ["tvt_teleporter_name", _name, false];
_teleporter setVariable ["tvt_teleporter_friendly_side", _firendly_side, false];
_teleporter setVariable ["tvt_teleporter_hostile_side", _hostile_side, false];
_teleporter setVariable ["tvt_teleporter_min_distance", _min_distance, false];

_fnc_disable = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setVariable ["tvt_teleporter_disabled", true, true];
	hint "Teleporter disabled!";
};
_disable_condition = 
	"!(_target getVariable [""tvt_teleporter_disabled"", false]) and " +
	"(side _this != _target getVariable ""tvt_teleporter_friendly_side"")";

if (_is_sink) then {
	_teleporter  addAction [
		("<t color=""#ff2d00"">" + ("Disable teleporter") + "</t>"),
		_fnc_disable,
		nil,
		1.5,
		true,
		true,
		"",
		_disable_condition
	];
};

_fnc_enable = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_target setVariable ["tvt_teleporter_disabled", false, true];
	hint "Teleporter enabled!";
};
_enable_condition = 
	"(_target getVariable [""tvt_teleporter_disabled"", false]) and " +
	"(side _this != _target getVariable ""tvt_teleporter_friendly_side"")";

if (_is_sink) then {
	_teleporter  addAction [
		("<t color=""#000cff"">" + ("Enable teleporter") + "</t>"),
		_fnc_enable,
		nil,
		1.5,
		true,
		true,
		"",
		_enable_condition
	];
};

if (isNil "tvt_teleporter_sinks") then {tvt_teleporter_sinks = []};
if (_is_sink) then {
	tvt_teleporter_sinks pushBackUnique _teleporter;
};
if (_is_sink) exitWith {};
if (isNil "tvt_teleporter_sources") then {tvt_teleporter_sources = []};
if (_is_source) then {
	tvt_teleporter_sources pushBackUnique _teleporter;
};

// Wait for all teleporters to be inisialized.
sleep 4;

_fnc_teleport = {
	params ["_target", "_caller", "_actionId", "_arguments"];

	private _sink = _arguments;
	private _hostile_side = _sink getVariable ["tvt_teleporter_hostile_side", sideUnknown];
	private _min_distance = _sink getVariable ["tvt_teleporter_min_distance", -1];
	private _disabled = _sink getVariable ["tvt_teleporter_disabled", false];
	
	if (_disabled) exitWith {
		hint "Teleporter disabled!";
	};
	private _near_men = nearestObjects [
		position _sink, ["man", "Car", "Tank"], _min_distance, true
	];
	hostile_is_near = (_near_men findIf {side _x == _hostile_side}) > -1;
	if (hostile_is_near) exitWith {
		hint format ["A member of side %1 is too close for you to use this teleporter!", _hostile_side];
	};
	_caller setPosATL (getPosATL _sink);
};
_teleport_condition = 
	"(side _this == _target getVariable ""tvt_teleporter_friendly_side"")";
{
	private _friendly_side = _x getVariable ["tvt_teleporter_friendly_side", sideUnknown];
	private _name = _x getVariable "tvt_teleporter_name";
	_teleporter addAction [
		"<t color=""#000cff"">" + _name + "</t>",
		_fnc_teleport,
		_x,
		1.5,
		true,
		true,
		"",
		_teleport_condition
	];
} forEach tvt_teleporter_sinks;

// Only run tracking part of the script if lock is undefined.
if !(isNil "tvt_teleporter_track_lock") exitWith {};
tvt_teleporter_track_lock = true;

_fnc_make_and_register_local_marker = {
	params ["_teleporter", "_colour", "_register"];
	private _name = _teleporter getVariable "tvt_teleporter_name";
	private _side = _teleporter getVariable "tvt_teleporter_friendly_side";
	if (side player != _side) exitWith {};
	private _marker = createMarkerLocal [
		str _teleporter,
		position _teleporter
	];
	_marker setMarkerTypeLocal "mil_dot";
	_marker setMarkerColorLocal _colour;
	_marker setMarkerTextLocal _name;
	_register pushBack _marker;
};

while {true} do {
	tvt_teleporter_markers = [];
	{
		[_x, "colorCivilian", tvt_teleporter_markers] call _fnc_make_and_register_local_marker;
	} forEach tvt_teleporter_sources;
	{
		[_x, "colorGreen", tvt_teleporter_markers]  call _fnc_make_and_register_local_marker;
	} forEach tvt_teleporter_sinks;

	sleep _tracker_delay;

	{deleteMarkerLocal _x} forEach tvt_teleporter_markers;
};
