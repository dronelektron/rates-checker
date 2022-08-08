static int g_clients[MAXPLAYERS + 1][MAXPLAYERS + 1];
static int g_clientsAmount[MAXPLAYERS + 1];

void Request_Reset(int target) {
    g_clientsAmount[target] = 0;
}

int Request_GetClient(int target, int index) {
    return g_clients[target][index];
}

void Request_AddClient(int target, int client) {
    g_clients[target][g_clientsAmount[target]] = client;
    g_clientsAmount[target]++;
}

int Request_GetClientsAmount(int target) {
    return g_clientsAmount[target];
}
