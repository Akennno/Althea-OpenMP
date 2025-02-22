// guard
#if defined _INC_Logger 
    #endinput
#endif
#define _INC_Logger

#if !defined _INC_open_mp
    #error "Please include 'open.mp' first before using this."
#endif


enum E_DEBUG_TYPE
{
    DEBUG_PLAYER,
    DEBUG_SERVER
};



forward OnServerDebug(const debug[], E_DEBUG_TYPE: type, va_args<>)
{

}