/*
    Easy Usefull Functions
    ________________________
    Creator:  Akenno.

    Requirements:
        - distance.inc: Kristoberg and Y_Less.



    ________________ Functions __________________

    givePlayerMoney(playerid, receiverid, money);    
    sendP2P(playerid, targetid);

    ________________ Callbacks __________________

    OnPlayerGiveMoney(playerid, receiverid, money);
    OnPlayerVirtualChange(playerid, oldvirtual, newvirtual);

*/
#if !defined _INC_open_mp
    #error "Please use this after include 'open.mp.inc'"
#endif

#if !defined _distance_included
    #error "Please use this after include 'distance'
#endif


#define EUF_sendSuccessMessage(%1,%2)       SendClientMessage(%1, 0x23FFB9FF, "|Success > {FFFFFF}"%2)
#define EUF_sendErrorMessage(%1,%2)         SendClientMessage(%1, 0xFD4466FF, "|Error > {FFFFFF}"%2)


new EUF_PlayerSpawned[MAX_PLAYERS];

forward OnPlayerGiveMoney(playerid, receiverid, money);
forward OnPlayerVirtualChange(playerid, oldvirtual, newvirtual);



// _________ Natives __________
static stock retPlayerName(playerid)
{
    static name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, MAX_PLAYER_NAME);

    return name;
}


static EUF_OnPlayerSpawn(playerid)
{
    if(EUF_PlayerSpawned[playerid] == 0)
        return Kick(playerid);
    
    EUF_PlayerSpawned[playerid] = 1;
    return 1;
}

static EUF_OnPlayerUpdate(playerid)
{
    if(EUF_PlayerSpawned[playerid] != 1)
        return Kick(playerid);
    
    new old_vw = GetPlayerVirtualWorld(playerid);
    if(old_vw == GetPlayerVirtualWorld(playerid))
        return 1;
    
    CallLocalFunction("OnPlayerVirtualChange", "dd", old_vw, GetPlayerVirtualWorld(playerid));

    return 1;
}

/*
________________________________________________________________
Name:
    - givePlayerMoney   (Memberikan uang kepada player lain)

Params:
    - playerid          | Id dari player yang memberikan uang
    - receiverid        | Id dari player yang menerima uang
    - money             | Jumlah uang yang akan diberikan
_________________________________________________________________
*/
givePlayerMoney(playerid, receiverid, money)
{
    if(money < 1 || GetPlayerMoney(playerid) < money)
        return 1;
    
    CallLocalFunction("OnPlayerGiveMoney", "iii", playerid, receiverid, money);
    return 1;
}


/*
__________________________________________________________
Name:
    - sendP2P(targetid, playerid)

Params:
    - playerid
    - targetid
__________________________________________________________
*/          
sendP2P(playerid, targetid)
{
    new Float: position[3];
    GetPlayerPos(targetid, position[0], position[1], position[2]);

    if(EUF_PlayerSpawned[targetid] == 1 || GetPlayerState(targetid) == PLAYER_STATE_SPAWNED)
    {
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
        SetPlayerInterior(playerid,GetPlayerInterior(targetid));
        SetPlayerPos(playerid, position[0]+1.2, position[1], position[2]);
    }
    return 1;
}

sendP2V(playerid, vehicleid)
{
    if(vehicleid == INVALID_VEHICLE_ID)
        return 1;
    
    new Float: vehpos[3];
    GetVehiclePos(vehicleid, vehpos[0], vehpos[1], vehipos[2]);
    
    SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(vehicleid));
    SetPlayerInterior(playerid, GetVehicleInterior(vehicleid));
    SetPlayerPos(playerid, vehpos[0]+1.2, vehpos[1], vehpos[2]);
    
    return 1;
}



/*
_________________________________________________
Name:
    - sendActionMessage

Params:
    - playerid
    - action[]
    - action_msg[]
_________________________________________________
*/
sendActionMessage(playerid, action[], action_msg[])
{
    new 
        fmt[144];
    
    format(fmt, sizeof fmt, "{FFAEB9}**[%s] %s: %s", action, retPlayerName(playerid), action_msg);
    for(new i ; i < Iter_Count(Player); i++) 
    {
        if(IsPlayerInRangeOfPlayer(playerid, i, 3.8))
        {
            SendClientMessage(i, -1, fmt);
            SetPlayerChatBubble(playerid, fmt, -1, 3.0, 4000);
        }
    }
    return 1;
}



/*
_______________________________________________________________
Name:
    - Basic files function: Create, Write, Read, Remove

Params:
    - const filename[] 
    - const data[]
    - const value[]

_______________________________________________________________
*/
static File: handle;

Create_Files(const filename[]) {

    handle = fopen(filename, io_write);
    return (handle) ? fclose(handle) : 0;
}

Remove_Files(const filename[]) {

    handle = fopen(filename, io_write);
    if(handle) {

        fremove(filename);
        fclose(handle);
    }
    return 1;
}

Read_Files(const filename[]) {

    handle = fopen(filename, io_read);
    
    new reader[256];
    if(handle) {
                
        fread(handle, reader);
        fclose(handle);
    }
    return reader;
}

Write_Files(const filename[], const data[], const value[]) {

    handle = fopen(filename, io_read);
    if(handle) {

        strins(data, ": ");
        fwrite(handle, data);
        fwrite(handle, value);
        fwrite(handle, "\n");

        fclose(handle);
    }
    return 1;
}






// ____________ Public _________
public OnPlayerGiveMoney(playerid, receiverid, money)
{    
    if(IsPlayerInRangeOfPlayer(playerid, receiverid, 2.5))
    {
        GivePlayerMoney(playerid, -money);
        GivePlayerMoney(playerid, money);

        EUF_sendSuccessMessage(playerid, "You've been give your money to %s", ReturnPlayerName(receiverid));
        EUF_sendSuccessMessage(receiverid, "%s give your %d money", ReturnPlayerName(playerid), money);
    } 
    else EUF_sendErrorMessage(playerid, "Player with id: %d, isn't connected to server", receiverid);
    return 1; 
}


// als & guard
#if defined _ALS_OnPlayerSpawn
    #undef OnPlayerSpawn
#endif
#define OnPlayerSpawn EUF_PlayerSpawned

#if defined _ALS_OnPlayerUpdate
    #undef OnPlayerUpdate
#endif
#define OnPlayerUpdate EUF_OnPlayerUpdate