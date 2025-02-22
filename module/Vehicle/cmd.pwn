CMD:myvehicle(playerid, params[])
{
    new fmt[200];
    if(VehicleSlot[playerid])
    {
        strcat(fmt, "#\tModel\tName\n");
        foreach( new i : Iter_Vehicle ) {
            if(Vehicle:ID[i] == Player:ID[playerid]) 
            {
                format(fmt, _, "%s%i\t%s\t%s\n", fmt, i, GetVehicleModelName(Vehicle:Model[i]), Vehicle:Name[i]);
                Dialog_Show(playerid, VehicleLists, DIALOG_STYLE_TABLIST_HEADERS, "Vehicle list(s)", fmt, "Select", "Close");
            }
        }
    }
    else Error_Message(playerid, "You don't have any vehicle");
    return 1;
}
Dialog:VehicleLists(playerid, response, listitem, inputtext[])
{
    if(response) 
    {
        new fmt[125];
        strcat(fmt, "Set vehicle name\nSpawn vehicle\n");
        strcat(fmt, "Despawn vehicle\nTrack vehicle\n");
        strcat(fmt, "Vehicle Information");

        SetPVarInt(playerid, "seletedVehicle", );
    }
}