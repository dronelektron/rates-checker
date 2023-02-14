void UseCase_OpenSettingsMenu(int client, int target) {
    Settings_QueryForClient(client, target, QueryType_Menu);
}

void UseCase_CheckSettings(int client) {
    Settings_QueryForServer(client, QueryType_Validation);
}

void UseCase_OnCheckSettings(int client, StringMap settings) {
    if (Variable_ValidationMode() == VALIDATION_MODE_NONE) {
        return;
    }

    char cvarName[CVAR_NAME_SIZE];
    char cvarValue[CVAR_VALUE_SIZE];

    for (int i = 0; i < Settings_Size(); i++) {
        Settings_GetCvarName(i, cvarName);
        Settings_Get(settings, cvarName, cvarValue);

        ValueType valueType = Settings_GetValueType(i);
        bool isValid;

        if (valueType == ValueType_Int) {
            isValid = UseCase_CheckInteger(client, cvarName, cvarValue);
        } else {
            isValid = UseCase_CheckFloat(client, cvarName, cvarValue);
        }

        if (!isValid) {
            break;
        }
    }
}

bool UseCase_CheckInteger(int client, const char[] cvarName, const char[] cvarValue) {
    if (!Validator_IsInt(cvarValue)) {
        KickClient(client, "%t", "Not integer value", cvarName, cvarValue);

        return false;
    }

    return true;
}

bool UseCase_CheckFloat(int client, const char[] cvarName, const char[] cvarValue) {
    if (!Validator_IsFloat(cvarValue)) {
        KickClient(client, "%t", "Not float value", cvarName, cvarValue);

        return false;
    }

    return true;
}

int UseCase_FindPreviousClient(int client) {
    for (int i = client - 1; i > 0; i--) {
        if (UseCase_IsValidClient(i)) {
            return i;
        }
    }

    return CLIENT_NOT_FOUND;
}

int UseCase_FindNextClient(int client) {
    for (int i = client + 1; i <= MaxClients; i++) {
        if (UseCase_IsValidClient(i)) {
            return i;
        }
    }

    return CLIENT_NOT_FOUND;
}

bool UseCase_IsValidClient(int client) {
    return IsClientInGame(client) && !IsFakeClient(client) && !IsClientSourceTV(client);
}
