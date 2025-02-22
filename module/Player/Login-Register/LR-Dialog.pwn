hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(dialogid)
        {
            case REGISTER_NAME:
            {
                new fUnderscore = strfind(inputtext, "_", false);
                if(stringLen(inputtext, 5, 24)) 
                {
                    if(fUnderscore != -1) 
                    {
                        if(fUnderscore > 1) {

                            Error_Message(playerid, "Invalid Name");
                            ShowPlayerDialogRegister(playerid);
                            return 1;
                        }
                        new Cache:cache = mysql_query(sqlConn, sprintf("SELECT * FROM Players WHERE PlayerName='%s'", inputtext));
                        if(cache_num_rows()) {

                            Error_Message(playerid, "This name already taken by other player.");
                            ShowPlayerDialogRegister(playerid);
                        }
                        
                        strcopy(Player:Name[playerid], inputtext); 
                        cache_delete(cache);
                        ShowPlayerDialogRegister(playerid);
                    }
                    else {

                        Error_Message(playerid, "Character Name must have \'_\'");
                        ShowPlayerDialogRegister(playerid);
                        return 1;
                    }
                }
            }
            case REGISTER_ORIGIN: {
                strcopy(Player:Origin[playerid], OriginPlace[listitem][str]);
                ShowPlayerDialogRegister(playerid);
            }
            case REGISTER_SEX: {
                Player:Sex[playerid] = (listitem == 0) ? Male : Female;
                ShowPlayerDialogRegister(playerid);
            }
            case REGISTER_BIRTHDATE:
            {
                new 
                    day, month, year,
                    currentYear,
                    age
                ;
                getdate(currentYear, _, _);

                if(sscanf(inputtext, "p</>ddd", day, month, year)) 
                    return ShowPlayerDialog(playerid, REGISTER_BIRTHDATE, DIALOG_STYLE_INPUT, "Create your character birthdate", "format: dd/mm/yyyy", "Create", "Cancel");
                
                age = CalculateAge(day, month, year);
                if(age >= currentYear)  {

                    Error_Message(playerid, "Invalid Age");
                    ShowPlayerDialogRegister(playerid);
                }
                Player:Birthdate[playerid][0] = day;
                Player:Birthdate[playerid][1] = month;
                Player:Birthdate[playerid][2] = year;
                Player:Age[playerid] = age;

                ShowPlayerDialogRegister(playerid);
            }
            case REGISTER_SKIN: {
                Player:Skin[playerid] = (Player:Sex[playerid] == Male) ? General_MaleSkin[listitem] : General_FemaleSkin[listitem];
                ShowPlayerDialogRegister(playerid);
            }
        }
    }
    return 1;
}


/* easyDialog */
Dialog:fRegisterChar(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: ShowPlayerDialog(playerid, REGISTER_NAME, DIALOG_STYLE_INPUT, "Create Character Name", "Create your roleplay name", "Create", "Cancel");
            case 1: {
                Server_Message(playerid, "Click \"Birthdate\"");
                ShowPlayerDialogRegister(playerid);
                return 1;
            }
            case 2: {

                new fmt[200];

                strcat(fmt, "Origin\n");
                for(new i; i < sizeof(OriginPlace); i++) {
                    format(fmt, _, "%s%s\n", fmt, OriginPlace[i][str]);
                }
                ShowPlayerDialog(playerid, REGISTER_ORIGIN, DIALOG_STYLE_TABLIST_HEADERS, "Select character origin", fmt, "Select", "Cancel");
            }
            case 3: ShowPlayerDialog(playerid, REGISTER_SEX, DIALOG_STYLE_LIST, "Select character sex", ""LIGHTSKYBLUE"Male\n"LIGHTPINK"Female", "Select", "Cancel");
            case 4: ShowPlayerDialog(playerid, REGISTER_BIRTHDATE, DIALOG_STYLE_INPUT, "Create your character birthdate", "format: dd/mm/yyyy", "Create", "Cancel");
            case 5:
            {
                new fmt[250];
                fmt[0] = '\0';

                new size = (Player:Sex[playerid] == Male) ? sizeof(General_MaleSkin) : sizeof(General_FemaleSkin);
                for(new i; i < size; i++) {
                    format(fmt, _, "%s%i\n", fmt, (Player:Sex[playerid] == Male) ? General_MaleSkin[i] : General_FemaleSkin[i]);
                }
                ShowPlayerDialog(playerid, REGISTER_SKIN, DIALOG_STYLE_PREVIEW_MODEL, "Select your skins", fmt, "Select", "Cancel");
            }
        }
    }
    else
    {
        // validation ...
        new query[300];
        Player:ID[playerid] = Account:AccountID[playerid] / 2 + random(101);

        mysql_format(sqlConn, query, sizeof query, "INSERT INTO Players (AccountName, PlayerID, PlayerName, PlayerSkin, PlayerSex, PlayerOrigin, PlayerAge) VALUES ('%e', '%d', '%e', '%d', '%d', '%e', '%d')", 
        ReturnPlayerName(playerid), Player:Name[playerid], Player:ID[playerid], Player:Skin[playerid], Player:Sex[playerid], Player:Origin[playerid], Player:Age[playerid]);

        mysql_tquery(sqlConn, query, "OnPlayerCreateCharacter", "d", playerid);
    }
    return 1;
}

Dialog:KeyAuth(playerid, response, listitem, inputtext[])
{
    if(response) 
    {
        if(!strlen(inputtext) || strlen(inputtext) > 8)
        {
            Error_Message(playerid, "You must enter a key between 1 and 8 characters.");
            Dialog_Show(playerid, KeyAuth, DIALOG_STYLE_INPUT, "Key Authenticator", "Your IP Address doesn't same with your last login", "Verify", "");
        }
        else 
        {
            if(strcmp(inputtext, Account:AccountKeys[playerid])) return Dialog_Show(playerid, LoginAuth, DIALOG_STYLE_INPUT, "Login Authenticator", "This account was registered, please input your password", "Login", "Quit");
            else {

                Error_Message(playerid, "Incorrect keys");
                Dialog_Show(playerid, KeyAuth, DIALOG_STYLE_INPUT, "Key Authenticator", "Your IP Address doesn't same with your last login", "Verify", "");
            }
        }
    }
    return 1;
}

Dialog:LoginAuth(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(!strlen(inputtext) || strlen(inputtext) < 2)
        {
            Error_Message(playerid, "You must enter a password between 8 and 32 characters.");
            Dialog_Show(playerid, LoginAuth, DIALOG_STYLE_INPUT, "Login Authenticator", "This account was registered, please input your password", "Login", "Quit");
        }
        else bcrypt_verify(playerid, "OnPlayerPasswordChecked", inputtext, Account:AccountPassword[playerid]);
    }
    return 1;
}

Dialog:CreatePassword(playerid, response, listitem, inputtext[])
{
    if(!response)
        return 1;
    
    return (stringLen(inputtext, 8, 32)) ? bcrypt_hash(playerid, "OnPlayerCreatePassword", inputtext, BCRYPT_COST) : Dialog_Show(playerid, CreatePassword, DIALOG_STYLE_INPUT, "Password Authenticator", "Please enter a password between 8 and 32 characters.", "Create", "Quit");
}

Dialog:CreateAuthKeys(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(stringLen(inputtext, 0, 8)) 
        {
            new Ip[39];
            GetPlayerIp(playerid, Ip);
            strcopy(Account:AccountKeys[playerid], inputtext);

            new query[300];
            mysql_format(sqlConn, query, sizeof query, "INSERT INTO Accounts (AccountID, AccountName, AccountPassword, AccountKeys, AccountIP) VALUES ('%d', '%e', '%e', '%e', '%e')", generateAccountID(playerid), ReturnPlayerName(playerid), Account:AccountPassword[playerid], Account:AccountKeys[playerid], Ip);
            mysql_tquery(sqlConn, query, "OnPlayerCreateAuth", "d", playerid);
        }
    }
    return 1;
}