enum PlayerSex
{
    Male,
    Female

    //Non_Binary (js kidding)
};

enum PlayerFaction_Type
{
    ALTHEA_CIVIL,
    ALTHEA_POLICE,
    ALTHEA_MEDICAL,
    ALTHEA_NEWS,
    ALTHEA_FIRE_FIGHTER
};


// -----------------------------------------------------------------------------------------------------------------------------------------------------------------

enum E_PLAYER_DATA
{
    Spawned,
    ID,
    Name[MAX_PLAYER_NAME],
    Level,
    Money,
    Delayed,
    Virtual,
    PlayerFaction_Type:Faction,
    Interior,
    Float:Health, Float:Armour,
    Float:Position[3], Float:Angle,


    // character data
    Origin[25],
    Age,
    PlayerSex:Sex,
    Skin,
    Birthdate[3],

    HbeMode,
    Hunger,
    Thirsty,
    Death,
    Injured
};

enum E_ACCOUNT_DATA
{
    AccountID,
    AccountName[32],
    AccountIP[39],
    AccountPassword[BCRYPT_HASH_LENGTH],
    AccountKeys[KEY_LENGTH]
};

// ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
    VARIABLE
*/

new     
    PlayerData[MAX_PLAYERS][E_PLAYER_DATA],
    AccountData[MAX_PLAYERS][E_ACCOUNT_DATA],
    sqlRace[MAX_PLAYERS]
;


#define Player:%1[%2]            PlayerData[%2][%1]
#define Account:%1[%2]           AccountData[%2][%1]