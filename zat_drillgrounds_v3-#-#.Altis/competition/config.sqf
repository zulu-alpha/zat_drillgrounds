/*

    Author: Phoenix of Zulu-Alpha

    Description: Configuration data to be initialized at start.
                 The competition_var_classes_### variables contains the class names or
                 parent class names of objects meant for those purposes.

    Params: None

    Returns: None

*/

if (isServer) then {
    competition_var_classes_interfaces = ["Land_InfoStand_V1_F", "Land_InfoStand_V2_F"];
    competition_var_classes_trigger = "EmptyDetector";
    competition_var_classes_gameLogic = "Logic";
    competition_var_name_setup = "competition_setup";
    competition_var_name_teardown = "competition_teardown";
    competition_var_name_TriggerRole = "competition_trigger_role";
    competition_var_name_TriggerStart = "start";
    competition_var_name_TriggerFinish = "finish";
    competition_var_name_TriggerEnemy = "enemies";
    competition_var_name_TriggerCiv = "civilians";
    competition_debug = false;
    competition_var_end_check_delay = 5.5;
};
