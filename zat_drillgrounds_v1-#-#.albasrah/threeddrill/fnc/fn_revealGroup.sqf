/*

    Author: Phoenix of Zulu-Alpha

    Description: Reveal all members of the given group to the given Observer.

    Params:
        0: OBJECT - Observer to be revealed to.
		1: GROUP - Group to reveal.

    Returns: None

*/

params ["_observer", "_group"];

{_observer reveal _x} forEach (units _group);
