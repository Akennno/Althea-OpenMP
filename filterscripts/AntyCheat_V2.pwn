#define FILTERSCRIPT

#include <open.mp>
#include <zcmd>
#include <sscanf2>
#include <pawn.RakNet>

// -
#define VERS "2.2"

#define C_GREEN 0x20DD6AFF
#define C_ERROR 0xA01616FF

#define MOBILE_CLIENT "ED40ED0E8089CC44C08EE9580F4C8C44EE8EE990"

#define KEY_PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

// -
new Text:acTD;
// -
new bool:pSuspicious[MAX_PLAYERS];
new bool:mobilePlayer[MAX_PLAYERS];
new bool:pAlreadyChecked[MAX_PLAYERS];
new bool:pCheck[MAX_PLAYERS];
// -
new pCheat[MAX_PLAYERS];
new pCheckTimer[MAX_PLAYERS][2];
new pCheckSum[MAX_PLAYERS];
// -
new rMemAddr[10];

enum PR_JoinData
{
	PR_iVersion,
 	PR_byteMod,
  	PR_byteNicknameLen,
   	PR_NickName[24],
    PR_uiClientChallengeResponse,
    PR_byteAuthKeyLen,
    PR_auth_key[50],
    PR_iClientVerLen,
    PR_ClientVersion[30]
};

// -
forward autoSobCheck(playerid);
forward kickPlayer(playerid);
forward putPIW(pID);
forward pCheckPlayer(pID);
forward respawnAfterDeath(playerid);
// -

new opcodes[10] = {
    0x06865E,
    0xA88774,
    0xDB6746,
    0xFDB957,
    0x52D558,
    0xE4FC58,
    0x1BA246,
    0xB0C56F,
    0xF9855E,
    0xF51D54  
};

// -- Commands --

CMD:checkp(playerid, params[])
{
	new pID, string[52];

	// -
	if ( !IsPlayerAdmin(playerid) ) return SendClientMessage(playerid, C_GREEN, "[Server]: You must be an Administrator to use this command!");
    if ( sscanf(params, "i", pID) ) return SendClientMessage(playerid, C_GREEN, "[Server]: /checkp [ID]");
    if ( pAlreadyChecked[pID] == true ) return SendClientMessage(playerid, C_ERROR, "[ERROR]: You've already checked this Player!");
    if ( !IsPlayerConnected(pID) ) return format(string, 52, "The player with the given ID: (%d) is not online!", pID), SendClientMessage(playerid, C_GREEN, string);

    SendClientMessage(playerid, C_GREEN, "[System]: A player check request has been sent!");

	// -
    pCheck[pID] = true;
    // -
    TextDrawShowForPlayer(pID, acTD);
    PlayerPlaySound(pID, 1185, 1985.1318, -141.6173, -6.6582);
	// --
	SetPlayerInterior(pID, 20);
	SetPlayerVirtualWorld(pID, pID+random(20));
	SetPlayerHealth(pID, 100.0);
    SetPlayerPosFindZ(pID, 1985.1318, -141.6173, -6.6582);
	// -
	pCheckTimer[pID][0] = SetTimerEx("putPIW", 900, true, "d", pID);
	pCheckTimer[pID][1] = SetTimerEx("pCheckPlayer", 78000, false, "d", pID);
	// -
	SendClientMessage(pID, C_ERROR, "[System]: You are under checking, please wait about 1,5 min");
	// -
	return 1;
}

// -- Callbacks --

public OnFilterScriptInit()
{
	print("--------------------------------------------------");
	print("\t");
	print("\t");
	print("	 AntyCheat "VERS" by Pevenaider loaded			 ");
	print("\t");
	print("\t");
	print("--------------------------------------------------");
	
	// -- TextDraw --
	acTD = TextDrawCreate(-101.000000, -41.000000, "LD_RCE4:race18");
	TextDrawBackgroundColour(acTD, 255);
	TextDrawFont(acTD, TEXT_DRAW_FONT:4);
	TextDrawLetterSize(acTD, 0.500000, 1.000000);
	TextDrawColour(acTD, 255);
	TextDrawSetOutline(acTD, 0);
	TextDrawSetProportional(acTD, true);
	TextDrawSetShadow(acTD, 1);
	TextDrawSetSelectable(acTD, false);
	return 1;
}

public OnPlayerConnect(playerid)
{
    new version[24], pAuth[43];
    
	// --
	mobilePlayer[playerid] = false;
    pSuspicious[playerid] = false;
	pAlreadyChecked[playerid] = false;
    pCheat[playerid] = -1;
    
	// -- Client version | GPCI --
    GetPlayerVersion(playerid, version, sizeof(version));
    GPCI(playerid, pAuth, sizeof(pAuth));

    if ( !strcmp ( MOBILE_CLIENT, pAuth, true ) )
	{
	    new pIP[16+1];
	    
	    GetPlayerIp(playerid, pIP, sizeof(pIP));

    	if (pCheckSum[playerid] == 0xBEEF)
		{
		    mobilePlayer[playerid] = true;
	    } else {
			SendClientMessage(playerid, C_ERROR, "[ERROR] There was a problem with the mobile version authentication, Your IP is temporarily blocked!");
			BlockIpAddress(pIP, 60 * 3000);
	    }
	}
	
	if ( strcmp ( version, "0.3.7" ) == 0 && mobilePlayer[playerid] == false )
	{
		SendClientMessage(playerid, C_ERROR, "[ERROR] The server requires a client version newer than 0.3.7 R1!");
		SetTimerEx("kickPlayer", 2000, false, "d", playerid);
	}

	if ( pCheck[playerid] == true )
	{
	    TextDrawHideForPlayer(playerid, acTD);
		KillTimer(pCheckTimer[playerid][0]);
		KillTimer(pCheckTimer[playerid][1]);
	    pCheck[playerid] = false;
	}

    // -
    SendClientCheck(playerid, 0x47, 0, 0, 0x4);
    SendClientCheck(playerid, 0x48, 0, 0, 0x4);
    // -
	
	for (new i = 0; i < 10; i++) rMemAddr[i] = anotherForm(opcodes[i]), SendClientCheck(playerid, 0x5, rMemAddr[i], 0x0, 0x4);

	// -- Check RPC --
    CallLocalFunction("Sec_OnClientCheckResponse", "iiii", playerid, 0x47, 0xCECECE, 256);
    CallLocalFunction("Sec_OnClientCheckResponse", "iiii", playerid, 0x48, 0xDEDEDE, 256);
	// -
	
	pCheckSum[playerid] = -1;
    SetTimerEx("autoSobCheck", 2900, false, "i", playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if ( pCheck[playerid] == true )
	{
	    TextDrawHideForPlayer(playerid, acTD);
		KillTimer(pCheckTimer[playerid][0]);
		KillTimer(pCheckTimer[playerid][1]);
	    pCheck[playerid] = false;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	if( pCheck[playerid] == true )
	{
	  	pAlreadyChecked[playerid] = true;
	   	pCheck[playerid] = false;
	   	// -
	    KillTimer(pCheckTimer[playerid][0]);
	    KillTimer(pCheckTimer[playerid][1]);
	    // -
	    SetTimerEx("respawnAfterDeath", 5000, false, "d", playerid);
	}
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(pCheck[playerid] == true)
	{
		SendClientMessage(playerid, -1, "[ERROR]: You can not use commands right now!");
		return 0;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(KEY_PRESSED(KEY_ACTION) && pCheck[playerid] == true) Kick(playerid);
	return 1;
}

public Sec_OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	switch(actionid)
	{
	    case 0x47:
	    {
	        if ( mobilePlayer[playerid] == false && memaddr == 0x0 && retndata != 256 )
	        {
	            pSuspicious[playerid] = false;
	        }
	        if ( mobilePlayer[playerid] == false && memaddr == 0xCECECE && retndata == 256 )
	        {
	            pSuspicious[playerid] = true;
	            // -
    			SendClientCheck(playerid, 0x47, 0, 0, 0x4);
	        }
	    }
	    case 0x48:
	    {
	        if ( mobilePlayer[playerid] == false && memaddr != 0xDEDEDE && retndata == 0 )
	        {
	            pSuspicious[playerid] = false;
	        }
	        if ( mobilePlayer[playerid] == false && memaddr == 0xDEDEDE && retndata == 256 )
	        {
	            pSuspicious[playerid] = true;
	            // -
    			SendClientCheck(playerid, 0x48, 0, 0, 0x4);
	        }
	    }
	    case 0x5:
	    {
		    if ( memaddr == rMemAddr[0] && retndata != 192) pCheat[playerid] = 1; // S0beit
		    if ( memaddr == rMemAddr[1] && retndata != 72) pCheat[playerid] = 2; // - CLEO
		    if ( memaddr == rMemAddr[2] && retndata != 192) pCheat[playerid] = 3;
		    if ( memaddr == rMemAddr[3] && retndata != 68) pCheat[playerid] = 4;
		    if ( memaddr == rMemAddr[4] && retndata != 196) pCheat[playerid] = 5;
		    if ( memaddr == rMemAddr[5] && retndata != 64) pCheat[playerid] = 6; // - CLEO
		    if ( memaddr == rMemAddr[6] && retndata != 8 ) pCheat[playerid] = 7; // CLEO5+Ultimate ASI Loader
			if ( memaddr == rMemAddr[7] && retndata != 200 ) pCheat[playerid] = 8; // SilentPatch
			if ( memaddr == rMemAddr[8] && retndata != 200 ) pCheat[playerid] = 9; // SampFuncs.asi
			if ( memaddr == rMemAddr[9] && retndata != 128 ) pCheat[playerid] = 10; // Sobfox.asi
		}
	}
	return 0;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
    #if defined Sec_OnClientCheckResponse
    	Sec_OnClientCheckResponse(playerid, actionid, memaddr, retndata);
    #endif
    return 1;
}
#if defined _ALS_OnClientCheckResponse
    #undef OnClientCheckResponse
#else
    #define _ALS_OnClientCheckResponse
#endif
#define OnClientCheckResponse Sec_OnClientCheckResponse
#if defined Sec_OnClientCheckResponse
    forward Sec_OnClientCheckResponse(playerid, actionid, memaddr, retndata);
#endif

public autoSobCheck(playerid)
{
	if ( mobilePlayer[playerid] == true )
	{
	    SendClientMessage(playerid, C_GREEN, "You’re currently playing the mobile version of SA-MP.");
	}
	// --
	if ( pSuspicious[playerid] == true )
	{
	    SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are probably using some mods. If you think this is a mistake, please contact the Admin.");
		SetTimerEx("kickPlayer", 2500, false, "d", playerid);
	}
	if ( pCheat[playerid] > 0 )
 	{
		for(new i = 0; i < 7; i++) SendClientMessage(playerid, -1, " ");
  		SendClientMessage(playerid, C_GREEN, "--------------------------------------------");
    }
	// --
	switch ( pCheat[playerid] )
	{
	    case 1:SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are using S0beit mod. Remove it and return to the server!"), SetTimerEx("kickPlayer", 2500, false, "d", playerid);
		case 2..6:SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are using CLEO mod. Remove it and return to the server!"), SetTimerEx("kickPlayer", 2500, false, "d", playerid);
		case 7:SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are using CLEO5+Ultimate ASI Loader mod. Remove it and return to the server!"), SetTimerEx("kickPlayer", 2500, false, "d", playerid);
		case 8:SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are using SilentPatch. Remove it and return to the server!"), SetTimerEx("kickPlayer", 2500, false, "d", playerid);
		case 9:SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are using SampFuncs. Remove it and return to the server!"), SetTimerEx("kickPlayer", 2500, false, "d", playerid);
		case 10:SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are using S0beit mod. Remove it and return to the server!"), SetTimerEx("kickPlayer", 2500, false, "d", playerid);
	}
	return 1;
}

forward OnIncomingRPC(playerid, rpcid, BitStream:bs);
public OnIncomingRPC(playerid, rpcid, BitStream:bs)
{
	switch ( rpcid )
	{
	    case 25:
	    {
        	new JoinData[PR_JoinData];
        	
        	BS_ReadJoinServer(bs, JoinData);
			BS_ReadUint16(bs, pCheckSum[playerid]);
		}
	}
	return 1;
}

/*
	Oxygen Checker
*/

public putPIW(pID)
{
	if ( pCheck[pID] == true )
	{
		if ( !IsPlayerInRangeOfPoint(pID, 100.0, 1985.1318, -141.6173, -6.6582) ) pUseSob(pID);

		new Float:health;
		GetPlayerHealth(pID, health);
		
		if ( health < 100.0 ) // Clean player
		{
	 		KillTimer(pCheckTimer[pID][0]);
	   		KillTimer(pCheckTimer[pID][1]);
		    //
		    SetPlayerInterior(pID, 0);
		    SetPlayerVirtualWorld(pID, 0);
		    TextDrawHideForPlayer(pID, acTD);
		 	PlayerPlaySound(pID, 1186, 0.0, 0.0, 0.0);
	   		//
	 		pCheck[pID] = false;
	 		pAlreadyChecked[pID] = true;
	 		SpawnPlayer(pID);
		}
		SetPlayerPosFindZ(pID, 1985.1318, -141.6173+random(4), -6.6582);
		SetPlayerFacingAngle(pID, 1+random(5));
	}
	return 1;
}

public pCheckPlayer(pID)
{
	new Float:health;
	GetPlayerHealth(pID, health);
	
	if ( health >= 100.0 )
	{
		pUseSob(pID);
     	pCheck[pID] = false;
    }
    return 1;
}

public respawnAfterDeath(playerid)
{
	SetPlayerInterior(playerid, 0);
 	SetPlayerVirtualWorld(playerid, 0);
	SpawnPlayer(playerid);
	// -
	TextDrawHideForPlayer(playerid, acTD);
	// -
 	PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
    return 1;
}
// -----

public kickPlayer(playerid) Kick(playerid);

// -
stock pUseSob(playerid)
{
	KillTimer(pCheckTimer[playerid][0]);
	KillTimer(pCheckTimer[playerid][1]);
    pCheck[playerid] = false;
    
	SendClientMessage(playerid, C_ERROR, "[ERROR] System has detected that you are using S0beit mod. Remove it and return to the server!"), SetTimerEx("kickPlayer", 2000, false, "d", playerid);
	return 1;
}

stock anotherForm(input)
{
    new result;

    #emit LOAD.S.pri input
    #emit CONST.alt 0xFF
    #emit AND
    #emit CONST.alt 16
    #emit SHL
    #emit STOR.S.pri result

    #emit LOAD.S.pri input
    #emit CONST.alt 0xFF00
    #emit AND
    #emit LOAD.S.alt result
    #emit ADD
    #emit STOR.S.pri result

    #emit LOAD.S.pri input
    #emit CONST.alt 0xFF0000
    #emit AND
    #emit CONST.alt 16
    #emit SHR
    #emit LOAD.S.alt result
    #emit ADD
    #emit STOR.S.pri result

    return result;
}

stock BS_ReadJoinServer(BitStream:bs, data[PR_JoinData])
{
    BS_ReadValue( bs, PR_INT32, data[PR_iVersion], PR_UINT8, data[PR_byteMod], PR_UINT8, data[PR_byteNicknameLen], PR_STRING, data[PR_NickName], data[PR_byteNicknameLen],
    	PR_UINT32, data[PR_uiClientChallengeResponse],
     	PR_UINT8, data[PR_byteAuthKeyLen],
      	PR_STRING, data[PR_auth_key], data[PR_byteAuthKeyLen],
       	PR_UINT8, data[PR_iClientVerLen]
	);
	
	BS_ReadValue( bs, PR_STRING, data[PR_ClientVersion], (data[PR_iClientVerLen] >= 30 ? 30:data[PR_iClientVerLen]) );
}