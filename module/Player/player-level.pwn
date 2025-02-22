#include <YSI_Coding\y_hooks>

#define LEVELUP_INTERVAL                4 // 4 jam

enum E_PLAYER_LOGTIME
{
    Hours,
    Minutes,
    Seconds
};
new PlayerLogin[MAX_PLAYERS][E_PLAYER_LOGTIME];


enum E_LEVELUP_REWARD
{
    Required,
    Reward
};



new const g_PlayerLevelUpRewards[][E_LEVELUP_REWARD] = {

    {2, 350},
    {5, 600},
    {10, 1000},
    {25, 2000}
};


ptask LoginTime_Update[1000](playerid) 
{
    PlayerLogin[playerid][Seconds]++;
    if(PlayerLogin[playerid][Seconds] == 60) {

        PlayerLogin[playerid][Seconds] = 0;
        PlayerLogin[playerid][Minutes]++;
        if(PlayerLogin[playerid][Minutes] == 60) {

            PlayerLogin[playerid][Minutes] = 0;
            PlayerLogin[playerid][Hours]++;
        }
    }
    if(PlayerLogin[playerid][Hours] == LEVELUP_INTERVAL) 
    {
        new level = Player:Level[playerid];
        level++;

        for(new i; i < sizeof(g_PlayerLevelUpRewards) ; i++) {

            if(g_PlayerLevelUpRewards[i][Required] == level) {

                givePlayerMoney(playerid, g_PlayerLevelUpRewards[i][Reward]);
                Server_Message(playerid, "Kamu mendapatkan uang sebesar %d karena sudah mencapai level %d", g_PlayerLevelUpRewards[i][Reward], level);
            }
        }
        PlayerLogin[playerid][Hours] = 0;
        SetPlayerScore(playerid, Player:Level[playerid]);
    }
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    return (Althea_IsPlayerSpawned(playerid) == true) ? LoginTime_Update(playerid) : false;
}