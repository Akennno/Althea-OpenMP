enum Player_Char
{
    charName[MAX_PLAYER_NAME]
};
new PlayerChar[MAX_PLAYERS][MAX_PLAYER_CHARACTER][Player_Char];


ShowPlayerDialogSelectCharacter(playerid)
{
    new 
        Cache: cache = mysql_query(sqlConn, sprintf("SELECT * FROM Players WHERE AccountName='%s' LIMIT "#MAX_PLAYER_CHARACTER"", Account:AccountName[playerid])),
        fmt[250];

    strcat(fmt, "Character Name\n");
    new rows = cache_num_rows();

    if(rows)
    {
        for(new i = 0; i < rows ; i++) 
        {
            cache_get_value(i, "PlayerName", PlayerChar[playerid][i][charName]);
            format(fmt, _, "%s%s\n", fmt, PlayerChar[playerid][i][charName]);

            if(rows < MAX_PLAYER_CHARACTER) {
                format(fmt, _, "%s[+] Add your character", fmt);
            }
        }
    }
    else format(fmt, _, "%s[+] Add your character\n", fmt);

    Dialog_Show(playerid, SelectCharacter, DIALOG_STYLE_TABLIST_HEADERS, "Select Character", fmt, "Select", "Cancel");
    cache_delete(cache);
    return 1;
}

Dialog:SelectCharacter(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(PlayerChar[playerid][listitem][charName] != EOS) {
            mysql_tquery(sqlConn, sprintf("SELECT * FROM Players WHERE PlayerName='%s'", PlayerChar[playerid][listitem][charName]), "OnCharacterDataLoaded", "d", playerid);
        } else {
            ShowPlayerDialogRegister(playerid);
        }
    }       
    return 1;
}