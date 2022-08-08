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

int Settings_Size(int client) {
    return g_settings[client].Size;
}

void Settings_Get(int client, const char[] consoleVariable, char[] value) {
    g_settings[client].GetString(consoleVariable, value, VARIABLE_MAX_SIZE);
}

void Settings_Set(int client, const char[] consoleVariable, const char[] value) {
    g_settings[client].SetString(consoleVariable, value, REPLACE_YES);
}
