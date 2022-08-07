static int g_settingsCounter[MAXPLAYERS + 1];

void UseCase_QuerySettings(int client) {
    g_settingsCounter[client] = 0;

    Settings_Set(client, CONSOLE_VARIABLE_INTERP, CONSOLE_VARIABLE_UNDEFINED);
    Settings_Set(client, CONSOLE_VARIABLE_INTERP_RATIO, CONSOLE_VARIABLE_UNDEFINED);
    Settings_Set(client, CONSOLE_VARIABLE_CMD_RATE, CONSOLE_VARIABLE_UNDEFINED);
    Settings_Set(client, CONSOLE_VARIABLE_UPDATE_RATE, CONSOLE_VARIABLE_UNDEFINED);
    Settings_Set(client, CONSOLE_VARIABLE_RATE, CONSOLE_VARIABLE_UNDEFINED);

    QueryClientConVar(client, CONSOLE_VARIABLE_INTERP, UseCaseCallback_QuerySettings);
    QueryClientConVar(client, CONSOLE_VARIABLE_INTERP_RATIO, UseCaseCallback_QuerySettings);
    QueryClientConVar(client, CONSOLE_VARIABLE_CMD_RATE, UseCaseCallback_QuerySettings);
    QueryClientConVar(client, CONSOLE_VARIABLE_UPDATE_RATE, UseCaseCallback_QuerySettings);
    QueryClientConVar(client, CONSOLE_VARIABLE_RATE, UseCaseCallback_QuerySettings);
}

public void UseCaseCallback_QuerySettings(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue) {
    Settings_Set(client, cvarName, cvarValue);

    g_settingsCounter[client]++;

    if (g_settingsCounter[client] == Settings_Size(client)) {
        UseCase_CheckSettings(client);
    }
}

bool UseCase_CheckSettingsByName(int client, const char[] consoleVariable) {
    if (StrEqual(consoleVariable, CONSOLE_VARIABLE_INTERP)) {
        return UseCase_IsInterpValid(client);
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_INTERP_RATIO)) {
        return UseCase_IsInterpRatioValid(client);
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_CMD_RATE)) {
        return UseCase_IsCmdRateValid(client);
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_UPDATE_RATE)) {
        return UseCase_IsUpdateRateValid(client);
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_RATE)) {
        return UseCase_IsRateValid(client);
    } else {
        ThrowError("Invalid console variable");
    }

    return false;
}

void UseCase_CheckSettings(int client) {
    bool isValidSettings = true;

    isValidSettings &= UseCase_IsInterpValid(client);
    isValidSettings &= UseCase_IsInterpRatioValid(client);
    isValidSettings &= UseCase_IsCmdRateValid(client);
    isValidSettings &= UseCase_IsUpdateRateValid(client);
    isValidSettings &= UseCase_IsRateValid(client);

    if (!isValidSettings && Variable_IsNotificationsEnabled()) {
        for (int i = 1; i <= MaxClients; i++) {
            if (IsClientInGame(i) && UseCase_IsPlayerAdmin(i)) {
                MessagePrint_PlayerHasBadSettings(client, i);
            }
        }
    }
}

bool UseCase_IsInterpValid(int client) {
    float minValue = Variable_GetMinInterp();
    float maxValue = Variable_GetMaxInterp();
    float value = UseCase_GetSettingsFloat(client, CONSOLE_VARIABLE_INTERP);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsInterpRatioValid(int client) {
    float minValue = Variable_GetMinInterpRatio();
    float maxValue = Variable_GetMaxInterpRatio();
    float value = UseCase_GetSettingsFloat(client, CONSOLE_VARIABLE_INTERP_RATIO);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsCmdRateValid(int client) {
    int minValue = Variable_GetMinCmdRate();
    int maxValue = Variable_GetMaxCmdRate();
    int value = UseCase_GetSettingsInt(client, CONSOLE_VARIABLE_CMD_RATE);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsUpdateRateValid(int client) {
    int minValue = Variable_GetMinUpdateRate();
    int maxValue = Variable_GetMaxUpdateRate();
    int value = UseCase_GetSettingsInt(client, CONSOLE_VARIABLE_UPDATE_RATE);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsRateValid(int client) {
    int minValue = Variable_GetMinRate();
    int maxValue = Variable_GetMaxRate();
    int value = UseCase_GetSettingsInt(client, CONSOLE_VARIABLE_RATE);

    return UseCase_InRange(minValue, value, maxValue);
}

int UseCase_GetSettingsInt(int client, const char[] consoleVariable) {
    char value[CONSOLE_VARIABLE_MAX_SIZE];

    Settings_Get(client, consoleVariable, value);

    return StringToInt(value);
}

float UseCase_GetSettingsFloat(int client, const char[] consoleVariable) {
    char value[CONSOLE_VARIABLE_MAX_SIZE];

    Settings_Get(client, consoleVariable, value);

    return StringToFloat(value);
}

bool UseCase_InRange(any min, any value, any max) {
    return min <= value && value <= max;
}

bool UseCase_IsPlayerAdmin(int client) {
    AdminId id = GetUserAdmin(client);

    return id != INVALID_ADMIN_ID && GetAdminFlag(id, Admin_Generic, Access_Effective);
}
