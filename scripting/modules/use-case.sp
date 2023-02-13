void UseCase_OnSettingsReady(int client, int target, QueryType queryType) {
    if (queryType == QueryType_Menu) {
        Menu_Rates(client, target);
    }
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
