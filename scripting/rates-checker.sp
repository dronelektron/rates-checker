#include <sourcemod>
#include <sdktools>
#include <regex>

#include "morecolors"

#include "rc/bundle"
#include "rc/console-variable"
#include "rc/menu"
#include "rc/message"
#include "rc/settings"
#include "rc/sound"
#include "rc/use-case"
#include "rc/validator"

#include "modules/bundle.sp"
#include "modules/console-command.sp"
#include "modules/console-variable.sp"
#include "modules/event.sp"
#include "modules/menu.sp"
#include "modules/message.sp"
#include "modules/settings.sp"
#include "modules/sound.sp"
#include "modules/use-case.sp"
#include "modules/validator.sp"

#define AUTO_CREATE_YES true

public Plugin myinfo = {
    name = "Rates checker",
    author = "Dron-elektron",
    description = "Allows you to check player rates",
    version = "1.4.1",
    url = "https://github.com/dronelektron/rates-checker"
};

public void OnPluginStart() {
    Command_Create();
    Variable_Create();
    Validator_Create();
    Event_Create();
    LoadTranslations("common.phrases");
    LoadTranslations("rates-checker.phrases");
    AutoExecConfig(AUTO_CREATE_YES, "rates-checker");
}

public void OnPluginEnd() {
    Validator_Destroy();
}

public void OnMapStart() {
    Sound_Precache();
}

public void OnClientPostAdminCheck(int client) {
    UseCase_CheckSettings(client);
}
