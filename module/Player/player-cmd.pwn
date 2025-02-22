// players cmd
cmd:pay(playerid, params[])
{
    new delimiter[2], amount, targetid;

    if(sscanf(params, "uP<.>d", targetid, delimiter, amount))  
        return Usage_Message(playerid, "/pay <targetid> <amount>");
    
    if(Althea_IsPlayerSpawned(targetid)) 
    {
        Info_Message(playerid, "You gave money to %s for %s", ReturnPlayerName(targetid), fmtMoney(amount, .delimiter = delimiter));
        Info_Message(targetid, "You received money from %s for %s", ReturnPlayerName(playerid), fmtMoney(amount, .delimiter = delimiter));

        givePlayerMoney(playerid, -amount);
        givePlayerMoney(targetid, amount);
    }
    return 1;
}

CMD:b(playerid, params[])
{
    if(!strlen(params)) 
        return Usage_Message(playerid, "/b [message] | For OOC Message don't abuse it.");
    
    SendNearbyMessage(playerid, 5.0, -1, "%s says: (( %s ))", ret_strreplace(ReturnPlayerName(playerid), "_", " "), params);
    return 1;
}