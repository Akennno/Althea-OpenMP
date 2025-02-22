#define AddPlayerBankATM(%1,%2,%3)        (%3 == BANK_ACCOUNT) ? BankATM[%1][accountMoney] += %2 : BankATM[%1][atmMoney] += %2
#define RemovePlayerBankATM(%1,%2,%3)     (%3 == BANK_ACCOUNT) ? BankATM[%1][accountMoney] -= %2 : BankATM[%1][atmMoney] -= %2


GenerateBankID(opt[], len)
{
    regenerate_bankAccount:
    opt[0] = '1' + random(9);
    for(new i; i < len; i++) {
        opt[i] = '0' + random(10);
    }
    opt[len] = '\0';

    new Cache: cache = mysql_query(sqlConn, sprintf("SELECT * FROM BankAccounts WHERE BankID='%s' OR AtmID='%s", opt, opt));
    if(cache_num_rows()) 
        goto regenerate_bankAccount;
    
    cache_delete(cache);
}

CreatePlayerBank(playerid)
{
    GenerateBankID(BankATM[playerid][accountID], MAX_BANK_LENGTH);
    GenerateBankID(BankATM[playerid][atmID], MAX_ATM_LENGTH);

    mysql_pquery(
        sqlConn, 
        sprintf(
            "INSERT INTO BankAccounts (Holder, BankID, AtmID) VALUES ('%s', '%d', '%d')",
            ReturnPlayerName(playerid), BankATM[playerid][accountID], BankATM[playerid][atmID]
        )
    );
    Info_Message(playerid, "Kamu telah membuat rekening baru dengan ID:%s", BankATM[playerid][accountID]);
    return 1;
}



// withdraw/deposit/transfer
withdrawPlayerBank(playerid, amount, e_BankType:type)
{
    if(BankATM[playerid][accountMoney] < amount)
        return 1;

    RemovePlayerBankATM(playerid, amount, type);
    Info(playerid, "You've withdraw %d from your bank %s", amount, (type == BANK_ACCOUNT) ? "Account" : "ATM");

    return 1;
}

depositPlayerBank(playerid, amount, e_BankType:type)
{
    if(BankATM[playerid][atmMoney] > amount)
        return 1;

    AddPlayerBankATM(playerid, amount, type);
    Info(playerid, "You've deposit %d to your bank %s", amount, (type == BANK_ACCOUNT) ? "Account" : "ATM");

    return 1;
}

transferBankMoney(playerid, targetid, amount)
{
    if(amount <= 0 || amount > BankATM[playerid][accountMoney])
        return Error_Message(playerid, "insuffent balance");
    
    if(Althea_IsPlayerSpawned(playerid)) 
    {
        AddPlayerBankATM(targetid, amount, BANK_ACCOUNT);
        RemovePlayerBankATM(playerid, amount, BANK_ACCOUNT);

        Info(playerid, "You've transfer %d to %s", amount, ReturnPlayerName(targetid));
    }
    else {
        
    }
    return 1;
}