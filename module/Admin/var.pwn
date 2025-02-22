enum admRank 
{
    None,
    Probationary,
    Junior,
    Senior,
    Executive,
    Chief
};

enum E_ADMIN_DATA
{
    ID,
    Name[32],
    admRank:Rank
};


new AdminData[MAX_PLAYERS][E_ADMIN_DATA];
#define Admin:%1[%2]            AdminData[%2][%1]


#define GetPlayerAdmin(%1,%2)       (Admin:Rank[%1] >= %2) ? true : false