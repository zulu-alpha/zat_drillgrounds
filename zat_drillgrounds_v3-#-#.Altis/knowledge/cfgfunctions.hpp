class knowledge
{
    class functions
    {
        file = "knowledge\fnc";
        class addMenuOptions
        {
            description = "Adds addaction options to the control object for the system.";
        };
        class mainLoop
        {
            description = "Runs local group update, circle drawing and draw job tasks in a loop for all groups regardless of locality.";
        };
        class groupUpdateKnowledge
        {
            description = "Updates the stored knowledge that a group has of the given player target.";
        };
        class allAIGroups
        {
            description = "Gets all groups that are has no players.";
        };
        class createCircle
        {
            description = "Creates simple local helper sings at the given post with the given radius and returns a reference for each created object.";
        };
        class updateCircle
        {
            description = "Creates or updates the circle for the given group player combination.";
        };
        class deleteCircle
        {
            description = "Deletes the circle for the given group target combination.";
        };
        class draw
        {
            description = "Draws all draw jobs in knowledge_drawJobs and knowledge_drawJobs_isNear.";
        };
        class getZoom
        {
            description = "Returns the zoom level of the player";
        };
    };
};
