#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    mysqlSetupConnection();
    setServerData();
    setServerData();
    loadGlobalTextdraws();

    return 1;
}

hook OnPlayerConnect(playerid)
{
    txdAltheaName(playerid);
    loadPlayerTextdraws(playerid);
    sendWelcomeMessage(playerid);
    
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    SavePlayerData(playerid);

    return 1;
}