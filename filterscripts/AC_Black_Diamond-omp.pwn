#include <open.mp>
#include <AC_Black_Diamond>


#define sendMessage(%1,%2)            SendClientMessage(%1, 0xcc4e9cff,%2)


public OnFilterScriptInit() 
{
    ACBD_ToggleConnectionMessage(true);
    return 1;
}


public OnOldVersionDetected(playerid)
{
    sendMessage(playerid, "You are using an outdated client. Please update to the latest version.");
    Kick(playerid);  
}   