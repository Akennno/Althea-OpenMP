#define Althea_IsPlayerSpawned(%1)          (Player:Spawned[%1] == 1) ? true : false


enum ALTHEA_TYPE
{
    ALTHEA_HEALTH,
    ALTHEA_ARMOUR
};

stock setPlayerHealthArmour(playerid, ALTHEA_TYPE:type, Float:amount)
{
    switch(type)
    {
        case ALTHEA_HEALTH:
        {
            Player:Health[playerid] += amount;
            SetPlayerHealth(playerid, Player:Health[playerid]);
        }
        case ALTHEA_ARMOUR:
        {
            Player:Armour[playerid] += amount;
            SetPlayerArmour(playerid, Player:Armour[playerid]);
        }
    }
    return 1;
}

stock givePlayerMoney(playerid, amount)
{
    new money = strval(fmtMoney(amount));

    Player:Money[playerid] += money;
    GivePlayerMoney(playerid, money);
    return 1;
}

stock setPlayerPos(playerid, Float: x, FLoat: y, Float: z)
{
    Float:ang; 
    GetPlayerFacingAngle(playerid, ang);

    Player:Position[playerid][0] = x;
    Player:Position[playerid][1] = y;
    Player:Position[playerid][2] = z;
    Player:Angle[playerid] = ang;

    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, ang);

    return 1;
}

SendNearbyMessage(playerid, Float:range, colour, str[144], va_args<>)
{
    foreach(new i : Player) 
    {   
        if(IsPlayerInRangeOfPlayer(i, playerid, range)) {

            str[0] = toupper(str[0]);
            SendClientMessage(i, colour, va_return(str, va_start<4>));
            SetPlayerChatBubble(playerid, str, colour, range, 3000);
        }
        else return 0;
    }
    return 1;
}

stock setPlayerDeath(playerid, bool:death)
{
    if(death)
    {
        setPlayerHealthArmour(playerid, ALTHEA_HEALTH, 20);
        ApplyAnimation(playerid, "RYDER", "RYD_Die_PT2", 4.2, true, false, false, true, 0, 1);
    }
    else
    {
        ClearAnimations(playerid, 1);
        setPlayerHealthArmour(playerid, ALTHEA_ARMOUR , 0);
        Server_Message(playerid, "Lagi mati suri");
    }
    return 1;
}

// ..
sendWelcomeMessage(playerid)
{
    Custom_Message(playerid, "WELCOME", "Hi "SV_COL_EMBED"@%s,"WHITE" welcome to "SV_NAME".", ReturnPlayerName(playerid));
    Info_Message(playerid, "Online Players: "LIGHT_GREEN"%d Players", Iter_Count(Player));

    return 1;
}