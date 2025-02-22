#define INVALID_VEHICLE_OWNER           -1
#define MAX_PLAYER_VEHICLE_SLOT         2


enum E_VEHICLE_DATA
{
    OwnerID,
    ID,
    Model,
    Key,
    fColor,
    sColor,
    Locked,
    Name[32],
    Plate[20],
    Float:Position[3],
    Float:Health = 1000,
    Float:Fuel = 100
};

new VehicleSlot[MAX_PLAYERS];
new vehicleData[MAX_VEHICLES][E_VEHICLE_DATA], Iterator:Iter_Vehicle<MAX_VEHICLES>;
#define Vehicle:%1[%2]      Vehicle[%2][%1]



SetVehicleInterior(%0,%1)