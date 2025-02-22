#define Server_Message(%1,%2)               SendClientMessage(%1, SV_COL, "(Althea): "WHITE""%2)
#define Error_Message(%1,%2)                SendClientMessage(%1, Y_RED4, "(Error): "WHITE""%2)
#define Info_Message(%1,%2)                SendClientMessage(%1, Y_LIGHT_YELLOW, "(Info): "WHITE""%2)
#define Usage_Message(%1,%2)                SendClientMessage(%1, X11_GRAY, "(Usage): "WHITE""%2)
#define Custom_Message(%1,%2,%3)            SendClientMessage(%1, Y_LIGHT_SKY_BLUE, "("%2"): "WHITE""%3)

