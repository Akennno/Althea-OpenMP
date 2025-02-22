loadGlobalTextdraws()
{
    altheaLogo[0] = TextDrawCreate(593.000, 416.000, "Althea");
    TextDrawLetterSize(altheaLogo[0], 0.589, 1.800);
    TextDrawAlignment(altheaLogo[0], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(altheaLogo[0], 1531026687);
    TextDrawSetShadow(altheaLogo[0], 0);
    TextDrawSetOutline(altheaLogo[0], 0);
    TextDrawBackgroundColour(altheaLogo[0], 150);
    TextDrawFont(altheaLogo[0], TEXT_DRAW_FONT_0);
    TextDrawSetProportional(altheaLogo[0], true);

    altheaLogo[1] = TextDrawCreate(599.000, 429.000, "Project");
    TextDrawLetterSize(altheaLogo[1], 0.250, 1.200);
    TextDrawAlignment(altheaLogo[1], TEXT_DRAW_ALIGN_LEFT);
    TextDrawColour(altheaLogo[1], -1);
    TextDrawSetShadow(altheaLogo[1], 0);
    TextDrawSetOutline(altheaLogo[1], 0);
    TextDrawBackgroundColour(altheaLogo[1], 150);
    TextDrawFont(altheaLogo[1], TEXT_DRAW_FONT_3);
    TextDrawSetProportional(altheaLogo[1], true);
}

loadPlayerTextdraws(playerid)
{
    fAlthea_HBE[playerid][0] = CreatePlayerTextDraw(playerid, 547.000, 419.000, "V");
    PlayerTextDrawLetterSize(playerid, fAlthea_HBE[playerid][0], 0.290, -1.100);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][0], 512819199);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][0], 150);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][0], true);

    fAlthea_HBE[playerid][1] = CreatePlayerTextDraw(playerid, 555.000, 415.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][1], 43.000, 3.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][1], -2139062017);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][1], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][1], true);

    fAlthea_HBE[playerid][2] = CreatePlayerTextDraw(playerid, 546.000, 413.000, "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][2], 9.000, 9.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][2], 512819199);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][2], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][2], true);

    fAlthea_HBE[playerid][3] = CreatePlayerTextDraw(playerid, 549.000, 413.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][3], 3.000, 3.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][3], 512819199);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][3], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][3], true);

    fAlthea_HBE[playerid][4] = CreatePlayerTextDraw(playerid, 555.000, 415.000, "LD_SPAC:white"); // haus
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][4], 43.000, 3.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][4], 512819199);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][4], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][4], true);

    fAlthea_HBE[playerid][5] = CreatePlayerTextDraw(playerid, 539.000, 400.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][5], 9.000, 2.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][5], -5963521);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][5], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][5], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][5], true);

    fAlthea_HBE[playerid][6] = CreatePlayerTextDraw(playerid, 539.000, 398.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][6], 9.000, 1.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][6], -2686721);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][6], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][6], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][6], true);

    fAlthea_HBE[playerid][7] = CreatePlayerTextDraw(playerid, 539.000, 397.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][7], 9.000, -1.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][7], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][7], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][7], true);

    fAlthea_HBE[playerid][8] = CreatePlayerTextDraw(playerid, 537.000, 391.000, "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][8], 13.000, 8.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][8], -5963521);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][8], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][8], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][8], true);

    fAlthea_HBE[playerid][9] = CreatePlayerTextDraw(playerid, 539.000, 397.000, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][9], 9.000, -1.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][9], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][9], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][9], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][9], true);

    fAlthea_HBE[playerid][10] = CreatePlayerTextDraw(playerid, 550.000, 396.000, "LD_SPAC:white"); 
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][10], 38.000, 3.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][10], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][10], -2139062017);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][10], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][10], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][10], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][10], true);

    fAlthea_HBE[playerid][11] = CreatePlayerTextDraw(playerid, 550.000, 396.000, "LD_SPAC:white"); // lapar
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][11], 38.000, 3.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][11], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][11], -5963521);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][11], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][11], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][11], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][11], true);

    fAlthea_HBE[playerid][12] = CreatePlayerTextDraw(playerid, 548.000, 414.000, "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][12], 5.000, 6.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][12], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][12], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][12], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][12], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][12], true);

    fAlthea_HBE[playerid][13] = CreatePlayerTextDraw(playerid, 549.000, 413.000, "LD_BEAT:chit");
    PlayerTextDrawTextSize(playerid, fAlthea_HBE[playerid][13], 5.000, 6.000);
    PlayerTextDrawAlignment(playerid, fAlthea_HBE[playerid][13], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, fAlthea_HBE[playerid][13], 512819199);
    PlayerTextDrawSetShadow(playerid, fAlthea_HBE[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, fAlthea_HBE[playerid][13], 0);
    PlayerTextDrawBackgroundColour(playerid, fAlthea_HBE[playerid][13], 255);
    PlayerTextDrawFont(playerid, fAlthea_HBE[playerid][13], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, fAlthea_HBE[playerid][13], true);

}