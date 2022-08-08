static int g_settingsCounter[MAXPLAYERS + 1];

void UseCase_QuerySettingsCheck(int client) {
    StringMap request = new StringMap();

    request.SetValue(REQUEST_CODE, RequestCode_CheckSettings);

    UseCase_QuerySettings(client, request);
}

void UseCase_QuerySettingsRefresh(int client, int target) {
    StringMap request = new StringMap();

    request.SetValue(REQUEST_CODE, RequestCode_RefreshSettings);
    request.SetValue(REQUEST_CLIENT, client);
    request.SetValue(REQUEST_TARGET, target);

    UseCase_QuerySettings(target, request);
}

void UseCase_QuerySettings(int client, StringMap request) {
    g_settingsCounter[client] = 0;

    Settings_Set(client, VARIABLE_INTERP, VARIABLE_UNDEFINED);
    Settings_Set(client, VARIABLE_INTERP_RATIO, VARIABLE_UNDEFINED);
    Settings_Set(client, VARIABLE_CMD_RATE, VARIABLE_UNDEFINED);
    Settings_Set(client, VARIABLE_UPDATE_RATE, VARIABLE_UNDEFINED);
    Settings_Set(client, VARIABLE_RATE, VARIABLE_UNDEFINED);

    QueryClientConVar(client, VARIABLE_INTERP, UseCaseCallback_QuerySettings, request);
    QueryClientConVar(client, VARIABLE_INTERP_RATIO, UseCaseCallback_QuerySettings, request);
    QueryClientConVar(client, VARIABLE_CMD_RATE, UseCaseCallback_QuerySettings, request);
    QueryClientConVar(client, VARIABLE_UPDATE_RATE, UseCaseCallback_QuerySettings, request);
    QueryClientConVar(client, VARIABLE_RATE, UseCaseCallback_QuerySettings, request);
}

public void UseCaseCallback_QuerySettings(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue, StringMap request) {
    Settings_Set(client, cvarName, cvarValue);

    g_settingsCounter[client]++;

    if (g_settingsCounter[client] == Settings_Size(client)) {
        UseCase_OnSettingsReady(client, request);
    }
}

public void UseCase_OnSettingsReady(int client, StringMap request) {
    int requestCode;

    if (!request.GetValue(REQUEST_CODE, requestCode)) {
        UseCase_ThrowErrorFromRequest(REQUEST_CODE);
    }

    if (requestCode == RequestCode_CheckSettings) {
        UseCase_CheckSettings(client);
    } else if (requestCode == RequestCode_RefreshSettings) {
        int requestClient;
        int requestTarget;

        if (!request.GetValue(REQUEST_CLIENT, requestClient)) {
            UseCase_ThrowErrorFromRequest(REQUEST_CLIENT);
        }

        if (!request.GetValue(REQUEST_TARGET, requestTarget)) {
            UseCase_ThrowErrorFromRequest(REQUEST_TARGET);
        }

        Menu_PlayerRates(requestClient, requestTarget);
    }
}

void UseCase_ThrowErrorFromRequest(const char[] requestField) {
    ThrowError("Request '%s' is not found", requestField);
}

bool UseCase_CheckSettingsByName(int client, const char[] consoleVariable) {
    if (StrEqual(consoleVariable, VARIABLE_INTERP)) {
        return UseCase_IsInterpValid(client);
    } else if (StrEqual(consoleVariable, VARIABLE_INTERP_RATIO)) {
        return UseCase_IsInterpRatioValid(client);
    } else if (StrEqual(consoleVariable, VARIABLE_CMD_RATE)) {
        return UseCase_IsCmdRateValid(client);
    } else if (StrEqual(consoleVariable, VARIABLE_UPDATE_RATE)) {
        return UseCase_IsUpdateRateValid(client);
    } else if (StrEqual(consoleVariable, VARIABLE_RATE)) {
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

    if (!isValidSettings && Variable_Notifications()) {
        for (int i = 1; i <= MaxClients; i++) {
            if (IsClientInGame(i) && UseCase_IsPlayerAdmin(i)) {
                MessagePrint_PlayerHasBadSettings(client, i);
            }
        }
    }
}

bool UseCase_IsInterpValid(int client) {
    float minValue = Variable_MinInterp();
    float maxValue = Variable_MaxInterp();
    float value = UseCase_GetSettingsFloat(client, VARIABLE_INTERP);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsInterpRatioValid(int client) {
    float minValue = Variable_MinInterpRatio();
    float maxValue = Variable_MaxInterpRatio();
    float value = UseCase_GetSettingsFloat(client, VARIABLE_INTERP_RATIO);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsCmdRateValid(int client) {
    int minValue = Variable_MinCmdRate();
    int maxValue = Variable_MaxCmdRate();
    int value = UseCase_GetSettingsInt(client, VARIABLE_CMD_RATE);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsUpdateRateValid(int client) {
    int minValue = Variable_MinUpdateRate();
    int maxValue = Variable_MaxUpdateRate();
    int value = UseCase_GetSettingsInt(client, VARIABLE_UPDATE_RATE);

    return UseCase_InRange(minValue, value, maxValue);
}

bool UseCase_IsRateValid(int client) {
    int minValue = Variable_MinRate();
    int maxValue = Variable_MaxRate();
    int value = UseCase_GetSettingsInt(client, VARIABLE_RATE);

    return UseCase_InRange(minValue, value, maxValue);
}

int UseCase_GetSettingsInt(int client, const char[] consoleVariable) {
    char value[VARIABLE_MAX_SIZE];

    Settings_Get(client, consoleVariable, value);

    return StringToInt(value);
}

float UseCase_GetSettingsFloat(int client, const char[] consoleVariable) {
    char value[VARIABLE_MAX_SIZE];

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
