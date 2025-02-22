hook OnPlayerConnect(playerid)
{
    sqlRace[playerid]++;
    
    mysql_pquery(sqlConn, sprintf("SELECT * FROM `Accounts` WHERE `AccountName`='%s' LIMIT 1", ReturnPlayerName(playerid)), "OnPlayerLogin", "dd", playerid, sqlRace[playerid]);
    SetPlayerColor(playerid, X11_GRAY);
    return 1;
}

cb:OnPlayerLogin(playerid, race)
{
    if(race != sqlRace[playerid])
        return Kick(playerid);
    
    if(cache_num_rows())
    {
        new Ip[39];
        GetPlayerIp(playerid, Ip);

        cache_get_value_int(0, "AccountID", Account:AccountID[playerid]);
        cache_get_value(0, "AccountName", Account:AccountName[playerid]);
        cache_get_value(0, "AccountIP", Account:AccountIP[playerid]);
        cache_get_value(0, "AccountKeys", Account:AccountKeys[playerid]);
        cache_get_value(0, "AccountPassword", Account:AccountPassword[playerid]);

        if(strcmp(Account:AccountIP[playerid], Ip)) Dialog_Show(playerid, KeyAuth, DIALOG_STYLE_INPUT, "Key Authenticator", "Your IP Address doesn't same with your last login", "Verify", "");
        else Dialog_Show(playerid, LoginAuth, DIALOG_STYLE_PASSWORD, "Login Authenticator", "This account was registered, please input your password", "Login", "Quit");
    }
    else Dialog_Show(playerid, CreatePassword, DIALOG_STYLE_INPUT, "Create Password", "This account wasn't registered yet. Please create your password", "Confirm", "");
    return 1;
}

cb:OnPlayerPasswordChecked(playerid, bool:success)
{

    if(!success)  {

        Server_Message(playerid, "Please select your character");
        ShowPlayerDialogSelectCharacter(playerid);
    }
    else {
        
        LoginAttemps[playerid]++;
        Server_Message(playerid, "Incorrect password (%d/"#MAX_LOGIN_ATTEMPS")", LoginAttemps[playerid]);
        if(LoginAttemps[playerid] > MAX_LOGIN_ATTEMPS)  {

            Server_Message(playerid, "You have been kick for too many failed login attempts.");
            Kick(playerid);
        }
        Dialog_Show(playerid, LoginAuth, DIALOG_STYLE_INPUT, "Login Authenticator", "This account was registered, please input your password", "Login", "Quit");
    }
    return 1;
}

cb:OnPlayerCreatePassword(playerid)
{
    // get the passwrd hash
    new hash[BCRYPT_HASH_LENGTH];
    bcrypt_get_hash(hash);

    strcopy(Account:AccountPassword[playerid], hash);
    Dialog_Show(playerid, CreateAuthKeys, DIALOG_STYLE_INPUT, "Create Authenticator Keeys", "Maximum: 8 chars", "Create", "");
    return 1;
}

cb:OnPlayerCreateCharacter(playerid)
{
    SetSpawnInfo(playerid, NO_TEAM, Player:Skin[playerid], 1667.4335, -1239.5854, 233.3750, 132.9244);
    SetPlayerName(playerid, Player:Name[playerid]);
    SetPlayerColor(playerid, X11_WHITE);
    SetPlayerHealth(playerid, 100);

    Player:Spawned[playerid] = 1;
    SpawnPlayer(playerid);
    return 1;
}

cb:OnPlayerCreateAuth(playerid) {

    strcopy(Account:AccountName[playerid], ReturnPlayerName(playerid));
    ShowPlayerDialogRegister(playerid); 
}


cb:OnCharacterDataLoaded(playerid)
{

    // getplayer data
    cache_get_value_int(0, "PlayerID", Player:ID[playerid]);
    cache_get_value(0, "PlayerName", Player:Name[playerid]);
    cache_get_value_int(0, "PlayerLevel", Player:Level[playerid]);
    cache_get_value_int(0, "PlayerMoney", Player:Money[playerid]);
    cache_get_value_int(0, "PlayerVirtual", Player:Virtual[playerid]);
    cache_get_value_int(0, "PlayerInterior", Player:Interior[playerid]);

    cache_get_value_float(0, "PlayerHealth", Player:Health[playerid]);
    cache_get_value_float(0, "PlayerArmour", Player:Armour[playerid]);
    cache_get_value_float(0, "PlayerPosX", Player:Position[playerid][0]);
    cache_get_value_float(0, "PlayerPosY", Player:Position[playerid][1]);
    cache_get_value_float(0, "PlayerPosZ", Player:Position[playerid][2]);
    cache_get_value_float(0, "PlayerAngle", Player:Angle[playerid]);

    cache_get_value(0, "PlayerOrigin", Player:Origin[playerid]);
    cache_get_value_int(0, "PlayerAge", Player:Age[playerid]);
    cache_get_value_int(0, "PlayerSkin", Player:Skin[playerid]);
    cache_get_value_int(0, "PlayerSex", Player:Sex[playerid]);


    SetPlayerName(playerid, Player:Name[playerid]);
    SetSpawnInfo(playerid, NO_TEAM, Player:Skin[playerid], Player:Position[playerid][0], Player:Position[playerid][1], Player:Position[playerid][2], Player:Angle[playerid]);
    SetPlayerHealth(playerid, Player:Health[playerid]);
    SetPlayerArmour(playerid, Player:Armour[playerid]);

    SetPlayerScore(playerid, Player:Level[playerid]);
    SetPlayerInterior(playerid, Player:Interior[playerid]);
    SetPlayerVirtualWorld(playerid, Player:Virtual[playerid]);
    GivePlayerMoney(playerid, Player:Money[playerid]);
    SetPlayerSkin(playerid, Player:Skin[playerid]);

    Player:Spawned[playerid] = 1;
    return SpawnPlayer(playerid);
}