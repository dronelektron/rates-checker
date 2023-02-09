int UseCase_FindPreviousClient(int client) {
    for (int i = client - 1; i > 0; i--) {
        if (UseCase_IsRealClient(i)) {
            return i;
        }
    }

    return CLIENT_NOT_FOUND;
}

int UseCase_FindNextClient(int client) {
    for (int i = client + 1; i <= MaxClients; i++) {
        if (UseCase_IsRealClient(i)) {
            return i;
        }
    }

    return CLIENT_NOT_FOUND;
}

bool UseCase_IsRealClient(int client) {
    return IsClientInGame(client) && !IsFakeClient(client);
}
