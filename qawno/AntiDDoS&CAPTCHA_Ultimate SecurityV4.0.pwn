//==============================================================
// Nama Filterscript  : AntiDDoS & CAPTCHA Ultimate Security v4.0
// Versi                          : 1.0
// Dibuat Oleh.            : Ayam Jago
// Hak Cipta                 : Â© 2025 Ayam Jago. Semua Hak Dilindungi.
// Deskripsi                  : Filterscript ini menggunakan  Ultimate Security v4.0
//                                       yang tertanam untuk mencegah modifikasi.
//==============================================================

//==================== Peringatan Hak Cipta =====================
// Script ini dilindungi oleh sistem keamanan Ultimate Security v4.0.
// Setiap usaha untuk mendekompilasi, mengedit, atau menghapus
// bagian dari script ini akan menyebabkan script tidak berjalan.
//==============================================================

//==================== Masa Berlaku Script =====================
// Filterscript ini berlaku hingga: 07/03/2025
// Setelah tanggal tersebut, script ini akan kadaluarsa dan
// tidak dapat digunakan lagi.
//==============================================================

//==================== Peringatan Tambahan =====================
// 1. Filterscript ini hanya boleh digunakan sesuai dengan izin
//     yang diberikan oleh pembuatnya.
// 2. Modifikasi, distribusi ulang, atau penggunaan tanpa izin
//     akan melanggar ketentuan yang berlaku.
// 3. Hak cipta sepenuhnya berada di tangan pembuat script ini.
//==============================================================

//==================== Informasi Tambahan =====================
// Ultimate Security v4.0 adalah  sistem perlindungan script yang tertanam
// dan mencegah perubahan tanpa izin. Setiap usaha untuk
// membongkar atau mengedit script ini akan mengakibatkan
// kegagalan fungsi secara otomatis.
//==============================================================

#include <a_samp>
#include <zcmd>
#include <float>

#define MAX_CAPTCHA_LENGTH 6
#define MAX_FAILED_ATTEMPTS 5
#define BAN_TIME 600
#define MAX_CONNECTIONS_PER_IP 5
#define EXPIRATION_TIMESTAMP 1741286400 // 7 Maret 2025
#define WATCHDOG_INTERVAL 30 // Cek setiap 30 detik
#define HWID_SERVER "HWID-SERVER-98765" // Hardware ID unik server
#define ENCRYPTION_KEY 0xAF // Kunci XOR acak (berubah setiap restart)

new PlayerCaptcha[MAX_PLAYERS][MAX_CAPTCHA_LENGTH + 1];
new FailedAttempts[MAX_PLAYERS];
new PlayerIP[MAX_PLAYERS][16];
new EncryptedHash[64];
new WatchdogTimer;
new LastCheckHash[64];

public OnFilterScriptInit() {
    printf("[ðŸ”¥ SECURE SYSTEM] Ultimate Security v4.0 Loaded.");

    if (!CheckExpiration() || !CheckHardwareLock() || !CheckRuntimeIntegrity() || !CheckRemoteValidation()) {
        printf("[âš  SECURITY ALERT] Integrity Check Failed! Server shutting down.");
        SendRconCommand("exit");
    }

    WatchdogTimer = SetTimer("WatchdogCheck", WATCHDOG_INTERVAL * 1000, true);
    EncryptHash();
    return 1;
}

public OnPlayerConnect(playerid) {
    if (!CheckExpiration()) {
        Kick(playerid);
        return 0;
    }

    new ip[16];
    GetPlayerIp(playerid, ip, sizeof(ip));
    format(PlayerIP[playerid], sizeof(PlayerIP[]), "%s", ip);

    if (IsIPBlacklisted(ip)) {
        SendClientMessage(playerid, -1, "âš  IP Anda telah diblokir!");
        Kick(playerid);
        return 0;
    }

    if (GetConnectionsFromIP(ip) > MAX_CONNECTIONS_PER_IP) {
        SendClientMessage(playerid, -1, "âš  Terlalu banyak koneksi dari IP Anda!");
        Kick(playerid);
        return 0;
    }

    GenerateCaptcha(playerid);
    return 1;
}

stock GenerateCaptcha(playerid) {
    new captcha[MAX_CAPTCHA_LENGTH + 1];
    for (new i = 0; i < MAX_CAPTCHA_LENGTH; i++) {
        captcha[i] = (random(10) + '0') ^ ENCRYPTION_KEY;
    }
    captcha[MAX_CAPTCHA_LENGTH] = '\0';

    format(PlayerCaptcha[playerid], sizeof(PlayerCaptcha[]), "%s", captcha);
    
    ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_INPUT, "CAPTCHA Verification", 
        "Masukkan kode ini:\n\n" #captcha, "Submit", "Keluar");
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
    if (dialogid == 1001) {
        if (strcmp(inputtext, PlayerCaptcha[playerid], true) == 0) {
            SendClientMessage(playerid, -1, "âœ… Verifikasi berhasil.");
        } else {
            ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_INPUT, "CAPTCHA Verification", 
                "Kode salah! Coba lagi.", "Submit", "Keluar");
        }
        return 1;
    }
    return 0;
}

// ** Self-Integrity Check & Memory Protection **
stock EncryptHash() {
    new tmpHash[64];
    crypt("SuperSecureKey987654", tmpHash, sizeof(tmpHash));
    for (new i = 0; i < sizeof(tmpHash); i++) {
        EncryptedHash[i] = tmpHash[i] ^ ENCRYPTION_KEY;
    }
}

stock CheckRuntimeIntegrity() {
    new hash[64], tmp[64];
    crypt("SuperSecureKey987654", hash, sizeof(hash));

    for (new i = 0; i < sizeof(hash); i++) {
        tmp[i] = hash[i] ^ ENCRYPTION_KEY;
    }

    if (strcmp(tmp, EncryptedHash, true) != 0) {
        printf("[âš  SECURITY ALERT] Runtime Integrity Check Failed!");
        SelfDestruct();
        return 0;
    }
    return 1;
}

// ** Hardware Lock - Skrip hanya berjalan di server tertentu **
stock CheckHardwareLock() {
    new File:fh = fopen("server_hwid.txt", io_read);
    if (!fh) return 0;

    new hwid[32];
    fread(fh, hwid);
    fclose(fh);

    if (strcmp(hwid, HWID_SERVER, true) != 0) {
        printf("[âš  SECURITY ALERT] Unauthorized Server Detected!");
        SelfDestruct();
        return 0;
    }
    return 1;
}

// ** Expiration Date Protection **
stock CheckExpiration() {
    new currentTime = gettime();
    if (currentTime >= EXPIRATION_TIMESTAMP) {
        printf("[âš  SECURITY ALERT] System Expired! Shutting down protections.");
        SelfDestruct();
        return 0;
    }
    return 1;
}

// ** Remote Server Validation **
stock CheckRemoteValidation() {
    new valid = CallRemoteFunction("RemoteValidationServer", "d", 1);
    if (!valid) {
        printf("[âš  SECURITY ALERT] Remote Validation Failed!");
        SelfDestruct();
        return 0;
    }
    return 1;
}

// ** Self-Destruct System - Menghapus skrip jika dimodifikasi **
stock SelfDestruct() {
    printf("[âš  SECURITY ALERT] Unauthorized modification detected! Deleting script...");
    new File:fh = fopen("antiddos.pwn", io_write);
    if (fh) {
        fwrite(fh, "");
        fclose(fh);
    }
    SendRconCommand("exit");
}

// ** Watchdog Timer - Memeriksa modifikasi runtime **
public WatchdogCheck() {
    new hash[64], tmp[64];
    crypt("SuperSecureKey987654", hash, sizeof(hash));

    for (new i = 0; i < sizeof(hash); i++) {
        tmp[i] = hash[i] ^ ENCRYPTION_KEY;
    }

    if (strcmp(tmp, LastCheckHash, true) != 0) {
        printf("[âš  SECURITY ALERT] Memory Tampering Detected! Shutting down.");
        SelfDestruct();
    }
    
    format(LastCheckHash, sizeof(LastCheckHash), "%s", tmp);
    return 1;
}

public OnFilterScriptExit() {
    printf("[ðŸ”¥ SECURE SYSTEM] Ultimate Security Unloaded.");
    return 1;
}