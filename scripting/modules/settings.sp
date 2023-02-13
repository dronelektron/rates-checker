static char g_cvarNames[][] = {
    CVAR_CL_INTERP,
    CVAR_CL_INTERP_RATIO,
    CVAR_CL_CMD_RATE,
    CVAR_CL_UPDATE_RATE,
    CVAR_RATE
};

static StringMap g_settings[MAXPLAYERS + 1];
static int g_settingsCounter[MAXPLAYERS + 1];
static QueryType g_queryType[MAXPLAYERS + 1];

void Settings_Create(int client) {
    g_settings[client] = new StringMap();
}

void Settings_Destroy(int client) {
    delete g_settings[client];
}

int Settings_Size() {
    return sizeof(g_cvarNames);
}

void Settings_Get(int client, const char[] cvarName, char[] cvarValue) {
    g_settings[client].GetString(cvarName, cvarValue, CVAR_VALUE_SIZE);
}

void Settings_Set(int client, const char[] cvarName, const char[] cvarValue) {
    g_settings[client].SetString(cvarName, cvarValue);
}

void Settings_Query(int client, int target, QueryType queryType) {
    int clientId = GetClientUserId(client);

    g_settingsCounter[client] = 0;
    g_queryType[client] = queryType;

    for (int i = 0; i < Settings_Size(); i++) {
        Settings_Set(client, g_cvarNames[i], CVAR_VALUE_EMPTY);
        QueryClientConVar(target, g_cvarNames[i], Settings_Result, clientId);
    }
}

void Settings_Result(QueryCookie cookie, int target, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue, int clientId) {
    if (result != ConVarQuery_Okay) {
        return;
    }

    int client = GetClientOfUserId(clientId);

    if (client == INVALID_CLIENT) {
        return;
    }

    Settings_Set(client, cvarName, cvarValue);

    g_settingsCounter[client]++;

    if (g_settingsCounter[client] == Settings_Size()) {
        UseCase_OnSettingsReady(client, target, g_queryType[client]);
    }
}
