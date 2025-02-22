#define MAX_BANK_LENGTH                 12
#define MAX_ATM_LENGTH                  14


enum E_PLAYER_BANK_ACCOUNT
{
    // bank - account
    accountID[],
    accountName[MAX_PLAYER_NAME],
    accountMoney,

    // atm
    atmID[BANK_ATM_LENGTH],
    atmMoney
};
new BankATM[MAX_PLAYERS][E_PLAYER_BANK_ACCOUNT];

