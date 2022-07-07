static StringMap g_settings[MAXPLAYERS + 1];

void Settings_Create() {
    for (int i = 1; i <= MaxClients; i++) {
        g_settings[i] = new StringMap();
    }
}

void Settings_Destroy() {
    for (int i = 1; i <= MaxClients; i++) {
        delete g_settings[i];
    }
}

void Settings_Get(int client, const char[] consoleVariable, char[] value) {
    g_settings[client].GetString(consoleVariable, value, CONSOLE_VARIABLE_MAX_SIZE);
}

void Settings_Set(int client, const char[] consoleVariable, const char[] value) {
    g_settings[client].SetString(consoleVariable, value, CONSOLE_VARIABLE_REPLACE_YES);
}

void Settings_Query(int client) {
    Settings_Set(client, CONSOLE_VARIABLE_INTERP, CONSOLE_VARIABLE_UNDEFINED);
    Settings_Set(client, CONSOLE_VARIABLE_CMD_RATE, CONSOLE_VARIABLE_UNDEFINED);
    Settings_Set(client, CONSOLE_VARIABLE_UPDATE_RATE, CONSOLE_VARIABLE_UNDEFINED);
    Settings_Set(client, CONSOLE_VARIABLE_RATE, CONSOLE_VARIABLE_UNDEFINED);

    QueryClientConVar(client, CONSOLE_VARIABLE_INTERP, Settings_Callback);
    QueryClientConVar(client, CONSOLE_VARIABLE_CMD_RATE, Settings_Callback);
    QueryClientConVar(client, CONSOLE_VARIABLE_UPDATE_RATE, Settings_Callback);
    QueryClientConVar(client, CONSOLE_VARIABLE_RATE, Settings_Callback);
}

public void Settings_Callback(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue) {
    Settings_Set(client, cvarName, cvarValue);
}
