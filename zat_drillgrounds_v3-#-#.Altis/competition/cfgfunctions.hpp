class competition
{
    // class configs
    // {
    //     class config
    //     {
    //         file = "competition\config.sqf";
    //         description = "Configuration data to be initialized at start";
    //         preInit = 1;
    //     };
    // };
    class functions
    {
        file = "competition\fnc";
        // class register
        // {
        //     description = "Designate the role of the object and initiate the whole system.";
        // };
        class addMenuOptionsRange
        {
            description = "Add the standard set of addaction menu options (MVP for range).";
        };
        class addMenuOptionsCQC
        {
            description = "Add the standard set of addaction menu options (MVP for cqc).";
        };
        // class process
        // {
        //     description = "Recurse through all game logics and serialize their attributes.";
        // };
        class range
        {
            description = "MVP for open range";
        };
        class rangeCleanup
        {
            description = "MVP for finishing and cleaning up open range";
        };
        class cqc
        {
            description = "MVP for cqc";
        };
        class cqcCleanup
        {
            description = "MVP for finishing and cleaning up cqc";
        };
    };
};
