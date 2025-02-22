SavePlayerData(playerid)
{
    new query[1000], Float:lastPos[3], Float:health, Float:armour, Float:angle;

    GetPlayerHealth(playerid, health);
    GetPlayerArmour(playerid, armour);
    GetPlayerPos(playerid, lastPos[0], lastPos[1], lastPos[2]);
    GetPlayerFacingAngle(playerid, angle);


    mysql_format(sqlConn, query, sizeof query, "UPDATE Players SET ");
    mysql_format(sqlConn, query, sizeof query, "%sPlayerLevel='%d', PlayerVirtual='%d', PlayerInterior='%d', ", query, Player:Level[playerid], GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    mysql_format(sqlConn, query, sizeof query, "%sPlayerSkin='%d', PlayerPosX='%f', PlayerPosY='%f', PlayerPosZ='%f', ", query, Player:Skin[playerid], lastPos[0], lastPos[1], lastPos[2]);
    mysql_format(sqlConn, query, sizeof query, "%sPlayerHealth='%f', PlayerArmour='%f', PlayerAngle='%f'", query, health, armour, angle);

    mysql_tquery(sqlConn, query);
    return 1;
}