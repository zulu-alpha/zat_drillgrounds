/*

    Author: Phoenix of Zulu-Alpha

    Description: Wrapper for diag_log, but while prepending text.

    Params:
        0: STR - Text to log

    Returns: None

*/

if (competition_debug) then {
    diag_log format ["$$$$$$$$ Competition $$$$$$$$ : %1", _this select 0];
};
