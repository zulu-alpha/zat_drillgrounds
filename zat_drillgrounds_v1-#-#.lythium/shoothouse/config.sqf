/*

    Author: Phoenix of Zulu-Alpha

    Description: Configuration data to be initialized at start.
                 The shoothouse_var_classes_### variables contains the class names or
                 parent class names of objects meant for those purposes.

    Params: None

    Returns: None

*/

// Server only
if (isServer) then {

    shoothouse_var_player_array = [];
    shoothouse_var_hc_array = [];

    shoothouse_var_classes_interface = ["Land_InfoStand_V1_F"];
    shoothouse_var_classes_target = ["Man"];
    shoothouse_var_classes_door = ["Land_WiredFence_01_gate_F"];

    shoothouse_var_settings_target = [false, 0.25, 1];

    shoothouse_var_processed_groups = [];

    shoothouse_var_door_whitelist = ["Door", "Dvere", "Vrata"];
    shoothouse_var_door_blacklist = ["Locked", "handle"];

    shoothouse_var_unitPos_mapping = ["UP", "Middle", "DOWN"];
    shoothouse_var_stance_mapping = ["STAND", "CROUCH", "PRONE"];

};

// Client only
if (hasInterface) then {

    shoothouse_var_max_captive_distance = 100;

};

// HC only
if (!(isServer) and !(hasInterface)) then {



};

shoothouse_var_door_open = 1;
shoothouse_var_door_close = 0;