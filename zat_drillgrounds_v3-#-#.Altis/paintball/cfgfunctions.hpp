class paintball
{
    class functions
    {
        file = "paintball\fnc";
        class addParticipant
        {
            description = "Monitor participant for paintball mode and activate it for them (involves sending hit info and making it invulnerable).";
        };
        class removeParticipant
        {
            description = "Remove the invulnerability and monitoring of the paintball mode participant.";
        };
        class hintScores
        {
            description = "Hint all paintbal mode participant's scores.";
        };
        class clearScores
        {
            description = "Deletes all paintbal mode participant's scores.";
        };
        class addMenuOptions
        {
            description = "Create addaction options for enabling, disabling, or viewing scores of Paintball mode.";
        };
        class addEH
        {
            description = "Add the eventhandler to make hinting and scoring work."
        };
        class removeEH
        {
            description = "Remove the eventhandler that made hinting and scoring work."
        };
        class hint
        {
            description = "Simply a wrapper for hint, made to avoid whitelisting the hint command itself."
        };
    };
};
