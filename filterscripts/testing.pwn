#include <a_samp>
#include <streamer>
#include <foreach>


#define MAX_NPC_SIZE        100


enum g_NpcData 
{
    nID,
    nName[24],
    nSkin,
    nAnimation
};
new nData[MAX_NPC_SIZE][g_NpcData],
    Iterator: Iter_Npc