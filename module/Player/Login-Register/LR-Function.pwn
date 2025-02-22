CalculateAge(dd, mm, yy)
{
    new 
        currentYear,
        currentMonth,
        currentDay;
    
    getdate(currentYear, currentMonth, currentDay);
    new age = currentYear - yy;
    
    if(mm < currentMonth || (mm < currentMonth && dd < currentDay)) {
        age--;
    }
    return age;
}

generateAccountID(playerid)
{
    new 
        rand = random(1001),
        try
    ;

    regenerate:

    new id = 2 * (rand);
    new Cache: cache = mysql_query(sqlConn, sprintf("SELECT * FROM Accounts WHERE AccountID='%d'", id));

    if(cache_num_rows()) {
        try++;
        if(try > 5) {

            Server_Message(playerid, "Can't Generate ID | Silahkan screenshot ini dan kirim ke admin");
            Kick(playerid);
        }
        goto regenerate;
    }
    return id;
}

ShowPlayerDialogRegister(playerid)
{
    new
        fmt[200],
        sexs[20];
        
    sexs = (Player:Sex[playerid] == Male) ? ""LIGHTSKYBLUE"Male" : ""LIGHTPINK"Female";

    format(fmt, _, "Data\tValue\n");
    strcat(fmt, "Data\tValue\n");

    format(fmt, _, "%sName\t%s\nAge\t%d y.o\n", fmt, Player:Name[playerid], Player:Age[playerid]);
    format(fmt, _, "%sOrigin\t%s\nSex\t%s\n", fmt, Player:Origin[playerid], sexs);
    format(fmt, _, "%sBirthdate\t%d/%d/%d\n", fmt, Player:Birthdate[playerid][0], Player:Birthdate[playerid][1], Player:Birthdate[playerid][2]);
    format(fmt, _, "%sSkin\t%d", fmt, Player:Skin[playerid]);

    Dialog_Show(playerid, fRegisterChar, DIALOG_STYLE_TABLIST_HEADERS, "Character Registration", fmt, "Edit", "Confirm");
    return 1;
}

