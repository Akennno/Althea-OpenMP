// admin commands
CMD:createvehicle(playerid, params[])
{
    if(GetPlayerAdmin(playerid, Executive))
    {
        new 
            model,
            color[2],
            Float: spawnpos[3];
        
        GetPlayerPos(playerid, spawnpos[0], spawnpos[1], spawnpos[2]);
        if(sscanf(params, "ddd", model, color[0], color[1]))
            return Usage_Message(playerid, "/createvehicle [modelid] [color1] [color2]");
        
        Vehicle_Create(playerid, model, color[0], color[1], spawnpos[0], spawnpos[1], spawnpos[2]);
    }
    return 1;
}

