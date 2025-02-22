#include <open.mp>

main(){}

new Text: altheaLogo[1];
public OnGameModeInit()
{
	altheaLogo[0] = TextDrawCreate(599.000, 2.000, "mdl-1000:AltheaProject");
	TextDrawTextSize(altheaLogo[0], 40.000, 41.000);
	TextDrawAlignment(altheaLogo[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(altheaLogo[0], -1);
	TextDrawSetShadow(altheaLogo[0], 0);
	TextDrawSetOutline(altheaLogo[0], 0);
	TextDrawBackgroundColour(altheaLogo[0], 255);
	TextDrawFont(altheaLogo[0], TEXT_DRAW_FONT_SPRITE_DRAW);
	TextDrawSetProportional(altheaLogo[0], true);
}

public OnPlayerConnect(playerid)
{
	TextDrawShowForPlayer(playerid, altheaLogo[0]);
}