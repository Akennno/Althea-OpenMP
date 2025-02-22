#define SV_COL              0x6E409CFF
#define SV_COL_EMBED        "{6e409c}"

new const General_MaleSkin[] = 
{
    2,3,4,5,6,7,14,15,19,20,21,22,23,
    24,25,28,29,30,32,36,37,46,47,48,
    58,60,66,67,72,73,94,95,98,119,121,
    170,180,182,183,184,185,188,241,242,
    220,221,222,223,
    250,258,259,261,262,273,289,290,217
};

new const General_FemaleSkin[] = 
{
    41,55,56,151,169,190,191,
    192,193,195,214,215,216,
    224,225,226,223,263
};


setServerData()
{
    if(!mysqlSetupConnection()) 
        return 0;
    
    SendRconCommand("name %s", SV_NAME);
    SendRconCommand("game.map %s", SV_MAP);
    SendRconCommand("game.mode %s", SV_VERSION);
    SendRconCommand("language %s", SV_LANG);
    SendRconCommand("max_players %d", MAX_PLAYERS);

    return 1;
}

stock bool:stringLen(string[], min, max)
{
    new len = strlen(string);
    if(!len || len < min || len > max)
        return false;

    if(min > max || max > len || max < min) {
        return false;
    }
    return true;
}