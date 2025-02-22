#define IsVehicleLocked(%1)                 (Vehicle[%1][Locked]) ? false : true;

Vehicle_Create(playerid, modelid, fColor, sColor, Float: x, Float: y, Float:z) 
{
    new free = Iter_Free(Iter_Vehicle);
    if(free != -1) 
    {
        if(IsValidVehicleModelID(modelid)) 
        {
            Vehicle[free][Model] = CreateVehicle(modelid, x+1.1, y, z, 0.0,  fColor, sColor, -1);
            Vehicle[free][OwnerID] = Player:ID[playerid];
            Vehicle[free][fColor] = fColor;
            Vehicle[free][sColor] = sColor;
            VehicleSlot[playerid]++;
            
            Vehicle[free][ID] = free * 3;
            mysql_tquery(
                sqlConn,
                sprintf(
                    "INSERT INTO Vehicles (ID, Model, Owner, Slot, Color1, Color2, Health, Fuel, Locked, PosX, PosY, PosZ) VALUES ('%d', '%d', '%d', '%d', '%d', '%f', '%f', '%d', '%f', '%f', '%f')",
                    Vehicle[free][ID], modelid, Vehicle[free][OwnerID], VehicleSlot[playerid], fColor, sColor, Vehicle[free][Health], Vehicle[free][Fuel], Vehicle[free][Locked], x+1.1, y, z
                ),
                "OnVehicleCreated",
                "ddd",
                playerid, modelid, Vehicle[free][ID]
            );
        }
        else return Error_Message(playerid, "Invalid vehicle id");
    } 
    else Error_Message(playerid, "Vehicle limit reached");
    return 1;
}

Vehicle_Delete(id)
{
    if(Iter_Contains(Iter_Vehicle, id))
    {
        Vehicle[id][OwnerID] = INVALID_VEHICLE_OWNER;
        DestroyVehicle(Vehicle[id][model]);
        Vehicle[id][Model] = -1;
        vehicl[id][Health] = 1000;
        Vehicle[id][Fuel] = 100;
        Vehicle[id][fColor] = 0;
        Vehicle[id][sColor] = 0;
        Vehicle[id][Locked] = false;

        Vehicle[id][Name][0] = Vehicle[id][Plate][0] = '\0';
        Iter_Remove(Iter_Vehicle, id);
    }
    else Error_Message(playerid, "Invalid id.");
    return 1;
}

bool:IsPlayerNearVehicle(playerid)
{
    new Float:pos[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

    return (IsVehicleInRangeOfPoint2D(playerid, 3.0, pos[0], pos[1])) ? true : false;
}

