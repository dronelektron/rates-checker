#include <sourcemod>

#include "morecolors"

#pragma semicolon 1
#pragma newdecls required

#include "rc/console-variable"
#include "rc/menu"
#include "rc/message"
#include "rc/request"
#include "rc/settings"

#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/request.sp"
#include "modules/settings.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Rates checker",
    author = "Dron-elektron",
    description = "Allows you to check player rates",
    version = "1.1.2",
    url = "https://github.com/dronelektron/rates-checker"
};

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    LoadTranslations("rates-checker.phrases");
    AutoExecConfig(true, "rates-checker");
}

public void OnClientConnected(int client) {
    Settings_Create(client);
}

public void OnClientDisconnect(int client) {
    Settings_Destroy(client);
}

public void OnClientPostAdminCheck(int client) {
    UseCase_QuerySettingsCheck(client);
}
