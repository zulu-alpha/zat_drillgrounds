class threeddrill
{
    class configs
    {
        class config
        {
            file = "threeddrill\config.sqf";
            description = "Configuration data to be initialized at start";
            preInit = 1;
        };
    };
    class functions
    {
        file = "threeddrill\fnc";
        class addMenuOptions
        {
            description = "Adds addaction options to the control object for the system.";
        };
        class cursorTargetLoop
        {
            description = "Continually broadcasts the cursorTarget of the player while a participant.";
        };
        class hint
        {
            description = "Hint wrapper for remote exec security safety.";
        };
        class isAllCursorsOnTargets
        {
            description = "Checks if all the given player's cursors are on at least one of the given group's units.";
        };
        class newRound
        {
            description = "Spawns a random number and set of units at a random position relative to the given reference object. Also registers them with the reference object";
        };
        class randomPosition
        {
            description = "Selects a random spawn position relative to the given object.";
        };
        class revealGroup
        {
            description = "Reveal all members of the given group to the given Observer.";
        };
        class spawnRandomGroup
        {
            description = "Spawns a random number and set of units at a random position relative to the given reference object.";
        };
    };
};
