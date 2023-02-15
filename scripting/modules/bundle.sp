StringMap Bundle_CreateForClient(int client, QueryType queryType) {
    StringMap bundle = Bundle_CreateForServer(queryType);
    int clientId = GetClientUserId(client);

    bundle.SetValue(BUNDLE_KEY_CLIENT_ID, clientId);

    return bundle;
}

StringMap Bundle_CreateForServer(QueryType queryType) {
    StringMap bundle = new StringMap();
    StringMap settings = new StringMap();

    bundle.SetValue(BUNDLE_KEY_QUERY_TYPE, queryType);
    bundle.SetValue(BUNDLE_KEY_SETTINGS, settings);
    bundle.SetValue(BUNDLE_KEY_SUCCESS, true);
    bundle.SetValue(BUNDLE_KEY_COUNTER, 0);

    return bundle;
}

void Bundle_Destroy(StringMap bundle) {
    StringMap settings = Bundle_GetSettings(bundle);

    CloseHandle(settings);
    CloseHandle(bundle);
}

int Bundle_GetClientId(StringMap bundle) {
    return Bundle_GetValue(bundle, BUNDLE_KEY_CLIENT_ID);
}

QueryType Bundle_GetQueryType(StringMap bundle) {
    return Bundle_GetValue(bundle, BUNDLE_KEY_QUERY_TYPE);
}

StringMap Bundle_GetSettings(StringMap bundle) {
    return Bundle_GetValue(bundle, BUNDLE_KEY_SETTINGS);
}

void Bundle_SetCvar(StringMap bundle, const char[] cvarName, const char[] cvarValue) {
    StringMap settings = Bundle_GetValue(bundle, BUNDLE_KEY_SETTINGS);

    settings.SetString(cvarName, cvarValue);
}

bool Bundle_IsFailed(StringMap bundle) {
    return !Bundle_GetValue(bundle, BUNDLE_KEY_SUCCESS);
}

void Bundle_SetAsFailed(StringMap bundle) {
    bundle.SetValue(BUNDLE_KEY_SUCCESS, false);
}

int Bundle_GetCounter(StringMap bundle) {
    return Bundle_GetValue(bundle, BUNDLE_KEY_COUNTER);
}

void Bundle_IncrementCounter(StringMap bundle) {
    int counter = Bundle_GetValue(bundle, BUNDLE_KEY_COUNTER);

    bundle.SetValue(BUNDLE_KEY_COUNTER, counter + 1);
}

any Bundle_GetValue(StringMap bundle, const char[] key) {
    any value;

    if (!bundle.GetValue(key, value)) {
        LogError("No value for key '%s'", key);
    }

    return value;
}
