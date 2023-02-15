static char g_cvarNames[][] = {
    "cl_interp",
    "cl_interp_ratio",
    "cl_cmdrate",
    "cl_updaterate",
    "rate"
};

static ValueType g_valueType[] = {
    ValueType_Float,
    ValueType_Float,
    ValueType_Float, // Should be "Int", but Source Engine considers it as "Float", weird...
    ValueType_Int,
    ValueType_Int
};

void Settings_GetCvarName(int index, char[] cvarName) {
    strcopy(cvarName, CVAR_NAME_SIZE, g_cvarNames[index]);
}

ValueType Settings_GetValueType(int index) {
    return g_valueType[index];
}

void Settings_Get(StringMap settings, const char[] cvarName, char[] cvarValue) {
    settings.GetString(cvarName, cvarValue, CVAR_VALUE_SIZE);
}

int Settings_Size() {
    return sizeof(g_cvarNames);
}

void Settings_QueryForClient(int client, int target, QueryType queryType) {
    StringMap bundle = Bundle_CreateForClient(client, queryType);

    Settings_Query(target, bundle);
}

void Settings_QueryForServer(int target, QueryType queryType) {
    StringMap bundle = Bundle_CreateForServer(queryType);

    Settings_Query(target, bundle);
}

void Settings_Query(int target, StringMap bundle) {
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

    QueryType queryType = Bundle_GetQueryType(bundle);
    StringMap settings = Bundle_GetSettings(bundle);

    if (queryType == QueryType_Menu) {
        int clientId = Bundle_GetClientId(bundle);
        int client = GetClientOfUserId(clientId);

        if (client != INVALID_CLIENT) {
            Menu_Rates(client, target, settings);
        }
    } else {
        UseCase_OnCheckSettings(target, settings);
    }
}
