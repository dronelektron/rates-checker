static char g_cvarNames[][] = {
    "cl_interp",
    "cl_interp_ratio",
    "cl_cmdrate",
    "cl_updaterate",
    "rate"
};

void Settings_GetCvarName(int index, char[] cvarName) {
    strcopy(cvarName, CVAR_NAME_SIZE, g_cvarNames[index]);
}

void Settings_Get(StringMap settings, const char[] cvarName, char[] cvarValue) {
    settings.GetString(cvarName, cvarValue, CVAR_VALUE_SIZE);
}

int Settings_Size() {
    return sizeof(g_cvarNames);
}

void Settings_Query(int client, int target, QueryType queryType) {
    StringMap bundle = Bundle_Create(client, queryType);

    for (int i = 0; i < Settings_Size(); i++) {
        QueryClientConVar(target, g_cvarNames[i], Settings_Result, bundle);
    }
}

void Settings_Result(QueryCookie cookie, int target, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue, StringMap bundle) {
    if (result == ConVarQuery_Okay) {
        Bundle_SetCvar(bundle, cvarName, cvarValue);
    } else {
        Bundle_SetAsFailed(bundle);
    }

    Bundle_IncrementCounter(bundle);

    if (Bundle_GetCounter(bundle) == Settings_Size()) {
        Settings_UnpackBundle(bundle, target);
        Bundle_Destroy(bundle);
    }
}

void Settings_UnpackBundle(StringMap bundle, int target) {
    if (Bundle_IsFailed(bundle)) {
        return;
    }

    int client;

    if (Bundle_IsQueryFromConsole(bundle)) {
        client = CONSOLE;
    } else {
        int clientId = Bundle_GetClientId(bundle);

        client = GetClientOfUserId(clientId);

        if (client == INVALID_CLIENT) {
            return;
        }
    }

    QueryType queryType = Bundle_GetQueryType(bundle);
    StringMap settings = Bundle_GetSettings(bundle);

    UseCase_OnSettingsReady(client, target, queryType, settings);
}
