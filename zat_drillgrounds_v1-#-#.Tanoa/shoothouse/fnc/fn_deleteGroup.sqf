/*

    Author: Phoenix of Zulu-Alpha

    Description: Deletes the given group, all it's units and saved units in set variable to be sure.

    Params:
        0: OBJECT - Target group to delete

    Returns: None

*/

params ["_target_group"];

// Delete all units still in the group (lost junk deleted by server though object variable)
{
    deleteVehicle _x
} forEach units _target_group;

deleteGroup _target_group;
