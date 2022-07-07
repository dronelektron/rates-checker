#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#include "rc/settings"
#include "rc/menu"

#include "modules/console-command.sp"
#include "modules/settings.sp"
#include "modules/menu.sp"

public Plugin myinfo = {
    name = "Rates checker",
    author = "Dron-elektron",
    description = "Allows you to check player rates and force certain settings to be used",
    version = "0.1.0",
    url = "https://github.com/dronelektron/rates-checker"
};

public void OnPluginStart() {
    Command_Create();
    Settings_Create();
}

public void OnPluginEnd() {
    Settings_Destroy();
}

public void OnClientPostAdminCheck(int client) {
    Settings_Query(client);
}
