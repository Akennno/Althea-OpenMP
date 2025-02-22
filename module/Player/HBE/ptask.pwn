#include <YSI_Coding\y_hooks>


ptask PlayerHbeUpdate[HBE_UPDATE_INTERVAL](playerid) {
    updatePlayerHbeByMode(playerid, Player:HbeMode[playerid]);
    return 1;
}

ptask PlayerHungerUpdate[HUNGER_UPDATE_INTERVAL](playerid)
{
    if((Player:Injured[playerid] || Player:Death[playerid]) == 1)  
        return 1;
    
    Player:Hunger[playerid]--;

    if(Player:Hunger[playerid] <= 20) return Info_Message(playerid, "Jangan lupa makan untuk mengatasi rasa lapar kamu.");
    if(Player:Hunger[playerid] <= 10) return Info_Message(playerid, "Segeralah pergi makan untuk mengatasi rasa lapar mu.");
    if(Player:Hunger[playerid] <= 0) 
    {
        Player:Hunger[playerid] = 0;
        hungerWarning[playerid]++;
        setPlayerHealthArmour(playerid, ALTHEA_HEALTH, -random(3));

        if(hungerWarning[playerid] >= HUNGER_MAX_WARNING)  
        {
            setPlayerDeath(playerid, true);
            hungerWarning[playerid] = 0;
            return Info_Message(playerid, "Kamu telah mati karena kelaparan. (idiot)");
        }
    }
    return 1;
}


ptask PlayerThirstUpdate[THRIST_UPDATE_INTERVAL](playerid)
{
    if((Player:Injured[playerid] || Player:Death[playerid]) == 1)
        return 1;

    Player:Thirsty[playerid]--;

    if(Player:Thirsty[playerid] <= 25) return Info_Message(playerid, "Jangan lupa minum untuk mengatasi rasa haus kamu.");
    if(Player:Thirsty[playerid] <= 10) return Info_Message(playerid, "Segeralah pergi minum untuk mengatasi rasa haus mu.");
    if(Player:Thirsty[playerid] <= 0)
    {
        Player:Thirsty[playerid] = 0;
        thirstWarning[playerid]++;
        setPlayerHealthArmour(playerid, ALTHEA_HEALTH, -random(5));

        if(thirstWarning[playerid] >= THIRST_MAX_WARNING)
        {
            setPlayerDeath(playerid, true);
            thirstWarning[playerid] = 0;
            return Info_Message(playerid, "Kamu telah mati karena kehausan. (idiot)");
        }
    }
    return 1;
}


hook OnPlayerSpawn(playerid)
{
    if(Althea_IsPlayerSpawned(playerid))
    {
        PlayerHungerUpdate(playerid);
        PlayerThirstUpdate(playerid);

        // load player hbe mode from database
        new Cache: cache = mysql_query(sqlConn, sprintf("SELECT * FROM Players WHERE PlayerName='%s'", Player:Name[playerid]));
        if(cache_num_rows()) {

            cache_get_value_int(0, "HbeMode", Player:HbeMode[playerid]);
            cache_get_value_int(0, "Hunger", Player:Hunger[playerid]);
            cache_get_value_int(0, "Thirsty", Player:Thirsty[playerid]);
        }
        else Player:HbeMode[playerid] = HBE_DEFAULT;

        showPlayerHbeByMode(playerid, Player:HbeMode[playerid], false); 
        cache_delete(cache);
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    savePlayerHBE(playerid);
    
    return 1;
}



CMD:sethunger(playerid, params[])
{
    new hunger = strval(params);
    Player:Hunger[playerid] += hunger;

    return 1;
}

CMD:setthristy(playerid, params[])
{
    new hunger = strval(params);
    Player:Thirsty[playerid] += hunger;

    return 1;
}