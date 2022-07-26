/*

    Author: Phoenix of Zulu-Alpha

    Description: Continually broadcasts the cursorTarget of the player while a participant.

    Params:
        0: OBJECT - Reference object.

    Returns: None

*/

_this spawn {
	
	params ["_refObject"];

	while {player in (_refObject getVariable ["participants", []])} do {
		player setVariable ["cursorTarget", cursorTarget, true];
		sleep 0.1;
	}

};