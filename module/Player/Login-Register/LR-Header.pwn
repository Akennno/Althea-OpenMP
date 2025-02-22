#define MAX_LOGIN_ATTEMPS           3
#define MAX_PLAYER_CHARACTER        3


new LoginAttemps[MAX_PLAYERS];




// dialog register
enum 
{
    REGISTER_NAME,
    REGISTER_ORIGIN,
    REGISTER_SEX,
    REGISTER_BIRTHDATE,
    REGISTER_SKIN
};


enum OriginPlaces{str[32]};
new const OriginPlace[][OriginPlaces] = {
    {"Africa"},
    {"Asean"},
    {"Europe"},
    {"North America"},
    {"South America"},
    {"Oceania"}
};




#include <YSI_Coding\y_hooks>

#include "../module/Player/Login-Register/LR-PlayerChar.pwn"
#include "../module/Player/Login-Register/LR-SavePlayerData.pwn"
#include "../module/Player/Login-Register/LR-Callback.pwn"
#include "../module/Player/Login-Register/LR-Function.pwn"
#include "../module/Player/Login-Register/LR-Dialog.pwn"