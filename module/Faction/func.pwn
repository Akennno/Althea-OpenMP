#define IsPlayerCivilian(%1)            (Player:Faction[%1] == ALTHEA_CIVIL) (1) : (0)

stock getFactionName(playerid) 
{
    if(!IsPlayerCivilian(playerid))
    {
        for(new i; i < sizeof(Althea_FactionNames); i++) 
        {
            if(Player:Faction[playerid] == Althea_FactionNames[i][factionID]) 
                return Althea_FactionNames[i][factionName];
        }
    }
    return 1;
}