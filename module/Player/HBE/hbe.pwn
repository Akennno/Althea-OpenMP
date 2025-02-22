updatePlayerHbeByMode(playerid, PLAYER_HBE_MODE:mode)
{
    new
        Float:PlayerHunger,
        Float:PlayerThirsty;

    switch(mode)
    {
        case HBE_DEFAULT:
        {
            PlayerHunger = Player:Hunger[playerid] * 38.0/100;
            PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][11], PlayerHunger, 3.0);
            PlayerTextDrawShow(playerid, fAlthea_HBE[playerid][11]);

            PlayerThirsty = Player:Thirsty[playerid] * 43.0/100;
            PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][4], PlayerThirsty, 3.0);
            PlayerTextDrawShow(playerid, fAlthea_HBE[playerid][4]);
        }
    }
    return 1;
}

showPlayerHbeByMode(playerid, PLAYER_HBE_MODE:mode, bool:hide)
{
    if(hide)
    {
        switch(mode)
        {
            case HBE_DEFAULT:  
            {
                for(new i; i  < 14; i ++) {
                    PlayerTextDrawShow(playerid, fAlthea_HBE[playerid][i]);
                }
            }
        }
    }
    else
    {
        switch(mode)
        {
            case HBE_DEFAULT:  {
                for(new i ;  i < 14; i++) {
                    PlayerTextDrawHide(playerid, fAlthea_HBE[playerid][i]);
                }
            }
        }
    }
    return 1;
}

savePlayerHBE(playerid)
{
    mysql_tquery(
        sqlConn, 
        sprintf("UPDATE Players SET HbeMode='%d', Hunger='%d', Thirsty='%d' WHERE PlayerName='%s'", Player:HbeMode[playerid], Player:Hunger[playerid], Player:Thirsty[playerid], Player:Name[playerid])
    );
    return 1;
}