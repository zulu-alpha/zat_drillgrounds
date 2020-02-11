class competition
{
    class configs
    {
        class config
        {
            file = "competition\config.sqf";
            description = "Configuration data to be initialized at start";
            preInit = 1;
        };
    };
    class functions
    {
        file = "competition\fnc";
        class addFiredManEH
        {
            description = "Adds a fired event handler for tracking weapons used.";
        };
        class addHitEH
        {
            description = "Add the eventhandler to make hinting and scoring work.";
        };
        class addMenuOptions
        {
            description = "Add menu options to the controllers.";
        };
        class cleanup
        {
            description = "Resets the course and can be executed during (for cancellations) or after (for completions) the course.";
        };
        class doRound
        {
            description = "Execute the course.";
        };
        class hint
        {
            description = "Simply a wrapper for hint, made to avoid whitelisting the hint command itself for MP.";
        };
        class init
        {
            description = "Initializes the processing of the competition range.";
        };
        class KilledEHLoop
        {
            description = "Monitoring loop that adds killed event handler for civilians or enemies tracked by the relevant trigger and notifies players of their deaths.";
        };
        class log
        {
            description = "Wrapper for diag_log, but while prepending text.";
        };
        class recurseCourse
        {
            description = "Recurse through the range objects to process other game logics and triggers and build the course.";
        };
        class removeHitEH
        {
            description = "Remove the eventhandler that made hinting and scoring work.";
        };
        class setLabelledTrigger
        {
            description = "Checks if the given game logic is a valid trigger label, then assigns the trigger to the correct role to the other given game logic.";
        };
        class systemChat
        {
            description = "Simply a wrapper for systemChat, made to avoid whitelisting the hint command itself for MP.";
        };
        class wasRecursed
        {
            description = "Checks if the given game logic has been recursed before.";
        };
    };
};
