/**
* @author Phoenix of Zulu-Alpha
* @version 1
*
* Determines if the rank given is greater than or equal to the minimum rank given
* Works with addActions
*
* Example: nul = [rank player, "SERGEANT"] call compile preprocessFileLineNumbers "popTargets\popTargets_minRank.sqf";
*                [_playerRank, _minRank  ]
*
* @param _playerRank  The rank of the test object
* @param _minRank     Minimum Rank
* @return             True if the rank is greater than or equal to the requirement
*/

private ["_params","_playerRank","_minRank","_ranks","_pass"];

// Check if called from addaction
if ( typeName (_this select 0) == "OBJECT" && {typeName (_this select 1) == "OBJECT"} ) then {
	_params = _this select 3;
} else {
	_params = _this;
};

_playerRank = _params select 0;
_minRank = _params select 1;

// List of ranks in ascending order
_ranks = [
	"PRIVATE",
	"CORPORAL",
	"SERGEANT",
	"LIEUTENANT",
	"CAPTAIN",
	"MAJOR",
	"COLONEL"
];

// Check until either the min rank or player rank is found first
_pass = false;

if (_playerRank in _ranks) then {
	{
		if (_minRank == _x) exitWith {_pass = true};
		if (_playerRank == _x) exitWith {_pass = false};
	} forEach _ranks;
};

// Return result
_pass