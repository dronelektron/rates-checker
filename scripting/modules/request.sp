static ArrayList g_clients[MAXPLAYERS + 1];

void Request_Reset(int target) {
    delete g_clients[target];
}

int Request_GetClientsAmount(int target) {
    return g_clients[target].Length;
}

int Request_GetClient(int target, int index) {
    return g_clients[target].Get(index);
}

void Request_AddClient(int target, int client) {
    if (g_clients[target] == null) {
        g_clients[target] = new ArrayList();
    }

    if (g_clients[target].FindValue(client) == VALUE_NOT_FOUND) {
        g_clients[target].Push(client);
    }
}
