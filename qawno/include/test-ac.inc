#if defined _inc_ac_included
    #endinput
#endif
#define _inc_ac_included

#if !defined _INC_open_mp
    #error "Please use 'open.mp' include"
#endif


enum _: STAC_TYPE
{
    HEALTH_HACK,
    ARMOUR_HACK,
    FAKE_SPAWN_HACK,
    WEAPON_HACK,
    MONEY_HACK,
    AIRBREAK_HACK,
    TELEPORT_HACK,
    ONFOOT_SPEED_HACK
};


enum E_STAC_PLAYERDATA
{
    bool:stacSpawned,
    stacMoney,
    
    Float: stacHealth,
    Float: stacArmour,
    Float: stacPlayerPos[3]
};
new ac_PlayerData[MAX_PLAYERS][E_STAC_PLAYERDATA];


forward STAC_OnChecDetected(playerid, cheat[], STAC_TYPE: cheattype);



STAC_Init(playerid)
{
    ac_PlayerData[playerid][stacMoney] = GetPlayerMoney(playerid);
    ac_PlayerData[playerid][stacSpawned] = true;
    GetPlayerHealth(playerid, ac_PlayerData[playerid][stacHealth]);
    GetPlayerArmour(playerid, ac_PlayerData[playerid][stacArmour]);

    return 1;
}

STAC_GivePlayerMoney(playerid, money, bool: setmoney) {

    new data = (!setmoney) ? ac_PlayerData[playerid][stacMoney] = money : ac_PlayerData[playerid][stacMoney] += money;
    return 1;
}

STAC_CheatUpdate(playerid)
{
    // money hack
    new currentMoney = GetPlayerMoney(playerid);
    if(currentMoney != ac_PlayerData[playerid][stacMoney])
    {
        STAC_GivePlayerMoney(playerid, ac_PlayerData[playerid][stacMoney], true);
        CallLocalFunction("STAC_OnCheatDetected", "isi", playerid, "Money Hack", MONEY_HACK);
        return 1;
    }



    getplayerpos

}