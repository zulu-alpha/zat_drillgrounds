/*

    Author: Phoenix of Zulu-Alpha

    Description: Configuration data to be initialized at start.
                 The competition_var_classes_### variables contains the class names or
                 parent class names of objects meant for those purposes.

    Params: None

    Returns: None

*/

// Server only
if (isServer) then {
    competition_var_classes_interface = ["Land_InfoStand_V1_F"];
    competition_var_class_trigger = "EmptyDetector";
    competition_var_class_gameLogic = "Logic";
};
