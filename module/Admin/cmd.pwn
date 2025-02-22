cmd:setskin(playerid, params[])
{
    new skinid;
    if(GetPlayerAdmin(playerid, Junior)) 
    {
        if(sscanf(params, "i", skinid)) 
            return Usage_Message(playerid, "/setskin <skinid>");
    
        if(skinid <= 0 || skinid > 311)  return Error_Message(playerid, "Invalid skin id.");

        Player:Skin[playerid] = skinid;
        SetPlayerSkin(playerid, skinid);
    }
    return 1;
}


