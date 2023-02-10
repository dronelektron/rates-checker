#include <sourcemod>
#include <sdktools>

#include "rc/menu"
#include "rc/message"
#include "rc/settings"
#include "rc/sound"
#include "rc/use-case"

#include "modules/console-command.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/settings.sp"
#include "modules/sound.sp"
#include "modules/use-case.sp"

public Plugin myinfo = {
    name = "Rates checker",
    author = "Dron-elektron",
    description = "Allows you to check player rates",
    version = "1.2.0",
    url = "https://github.com/dronelektron/rates-checker"
};

public void OnPluginStart() {
    Command_Create();
    LoadTranslations("common.phrases");
    LoadTranslations("rates-checker.phrases");
}

public void OnMapStart() {
    Sound_Precache();
}

public void OnClientConnected(int client) {
    Settings_Create(client);
}

public void OnClientDisconnect(int client) {
    Settings_Destroy(client);
}
