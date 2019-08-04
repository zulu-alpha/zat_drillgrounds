class shootHouse
{
    class configs
    {
        class config
        {
            file = "shoothouse\config.sqf";
            description = "Configuration data to be initialized at start";
            preInit = 1;
        }
    };
    class functions
    {
        file = "shoothouse\fnc";
        class registerClient
        {
            description = "Has all clients register themselves with the server so it can track HCs and clients";
            postInit = 1;
        };
        class registerWithServer
        {
            description = "Tell server about the client so it can track it";
        };
        class processObjects
        {
            description = "Process synced objects";
        };
        class processTarget
        {
            description = "Process unit objects into target array and deletes unit";
        };
        class createMenu
        {
            description = "Creates the addaction menu items for the client and cleans old menu items if provided";
        };
        class requestSpawnGroups
        {
            description = "Spawns given groups on the correct machine for course object";
        }
        class spawnGroup
        {
            description = "Spawns each target in given group according to given settings and registers the group with the server for tracking and each target to the group (in case of error)";
        }
        class registerGroup
        {
            description = "Registers group as part of given course object";
        }
        class requestDeleteGroups
        {
            description = "Deletes all spawned targets for the given course object by having their owner machine do the deleting";
        }
        class hint
        {
            description = "Hints the given text. Used to avoid whitelisting command in CfgRemoteExec";
        }
        class deleteGroup
        {
            description = "Deletes the given group and all units in it.";
        }
        class totalUnits
        {
            description = "Returns cound of all units in array of groups";
        }
        class switchCaptive
        {
            description = "Switches captivity for given unit and removes captive once global var for max distance is exceeded";
        }
        class operateDoors
        {
            description = "Opens, closes or randomizes all doors in given building";
        }
        class requestOperateDoors
        {
            description = "Handles the client request to open, close or randomize all doors in course";
        }
    };
    class targetSettings
    {
        file = "shoothouse\fnc\targetsettings";
        class targetSettings_0_live
        {
            description = "Choose whether the targets should be live or not";
        }
        class targetSettings_1_percentage
        {
            description = "Choose the ratio of targets to spawn";
        }
        class targetSettings_2_skill
        {
            description = "Choose the skill level that the targets will have";
        }
        class targetSettings_3_skill_post
        {
            description = "Saves skill setting";
        }
    }
    class paintball
    {
        file = "shoothouse\fnc\paintball";
        class paintball_addParticipant
        {
            description = "Monitor participant for paintball mode and activate it for them (involves sending hit info and making it invulnerable).";
        }
        class paintball_removeParticipant
        {
            description = "Remove the invulnerability and monitoring of the paintball mode participant.";
        }
        class paintball_hintScores
        {
            description = "Hint all paintbal mode participant's scores.";
        }
        class paintball_clearScores
        {
            description = "Deletes all paintbal mode participant's scores.";
        }
        class paintball_createMenu
        {
            description = "Create addaction options for enabling, disabling, or viewing scores of Paintball mode.";
        }
    };
};
