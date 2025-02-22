/*
    +------------------------------------------------------------+
    | Glorp                                                      |
    |                                                            |
    |                                                            |
    |         d8888 888 888    888                               |
    |        d88888 888 888    888                               |
    |       d88P888 888 888    888                               |
    |      d88P 888 888 888888 88888b.   .d88b.   8888b.         |
    |     d88P  888 888 888    888 "88b d8P  Y8b     "88b        |
    |    d88P   888 888 888    888  888 88888888 .d888888        |
    |   d8888888888 888 Y88b.  888  888 Y8b.     888  888        |
    |  d88P     888 888  "Y888 888  888  "Y8888  "Y888888        |
    |                                                            |
    |                                                            |
    |                                                            |
    |  8888888b.                   d8b                   888     |
    |  888   Y88b                  Y8P                   888     |
    |  888    888                                        888     |  
    |  888   d88P 888d888 .d88b.  8888  .d88b.   .d8888b 888888  |
    |  8888888P"  888P"  d88""88b "888 d8P  Y8b d88P"    888     |
    |  888        888    888  888  888 88888888 888      888     |
    |  888        888    Y88..88P  888 Y8b.     Y88b.    Y88b.   |
    |  888        888     "Y88P"   888  "Y8888   "Y8888P  "Y888  |
    |                              888                           |
    |                             d88P                           |
    |                           888P"                            |
    |                                                            |
    |                                                            |
    |                                               Open.MP      |
    +------------------------------------------------------------+

*/

#include "../module/Assets/Settings.pwn"
#include <open.mp>
#undef MAX_PLAYERS
#define MAX_PLAYERS     2
#include <a_mysql>
#include <sscanf2>
#include <YSI_Data\y_iterate>
#include <YSI_Server\y_colours\y_colours_x11def>
#include <YSI_Game\y_vehicledata>
#include <samp_bcrypt>
#include <pawn-easing-functions>
#include <Pawn.CMD>
#include <distance>
#include <circleProgress>
#include <strlib>
#include <easyDialog>
#include <EVF>
#include <streamer>
#include <PreviewModelDialog2>
#include <ndialog-pages>
#include <YSI_Coding\y_timers>
#include <map-zones>
#include <samp-money-format>
#include "../module/modules.pwn"








/*
 .o88b.  .d8b.  db      db      d8888b.  .d8b.   .o88b. db   dD 
d8P  Y8 d8' `8b 88      88      88  `8D d8' `8b d8P  Y8 88 ,8P' 
8P      88ooo88 88      88      88oooY' 88ooo88 8P      88,8P   
8b      88~~~88 88      88      88~~~b. 88~~~88 8b      88`8b   
Y8b  d8 88   88 88booo. 88booo. 88   8D 88   88 Y8b  d8 88 `88. 
 `Y88P' YP   YP Y88888P Y88888P Y8888P' YP   YP  `Y88P' YP   YD 
                                                                
*/


main(){}
public OnPlayerText(playerid, text[])
{
    if(Althea_IsPlayerSpawned(playerid) && strlen(text)) 
    {
        if(GetTickCount() - Player:Delayed[playerid] >= SV_TICK) 
        {
            Player:Delayed[playerid] = GetTickCount();

            new fReplaceName[32]; 
            format(fReplaceName, _, "%s", ret_strreplace(ReturnPlayerName(playerid), "_", " "));
            SendNearbyMessage(playerid, 8.0, -1, "%s says: %s", fReplaceName, text);
        }
        else Error_Message(playerid, "You must be wait for %d seconds", Player:Delayed[playerid] / 1000);
    }
    return false;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if(Althea_IsPlayerSpawned(playerid))  
    {
        if(GetTickCount() - Player:Delayed[playerid] < SV_TICK)
            return Error_Message(playerid, "You must be wait for %d seconds", Player:Delayed[playerid] / 1000);
    }
    else Error_Message(playerid, "You must spawn first");
    Player:Delayed[playerid] = GetTickCount();

    return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{	
    if(result == -1) 
        return Custom_Message(playerid, "CMD", "Invalid commands \"/%s\" type \"/help\" to see available commands.", cmd);

    return 1;
}