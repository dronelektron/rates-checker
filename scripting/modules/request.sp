static ArrayList g_observers[MAXPLAYERS + 1];

void Request_Reset(int client) {
    delete g_observers[client];
}

int Request_GetObserversAmount(int client) {
    return g_observers[client].Length;
}

int Request_GetObserver(int client, int index) {
    return g_observers[client].Get(index);
}

void Request_AddObserver(int client, int observer) {
    if (g_observers[client] == null) {
        g_observers[client] = new ArrayList();
    }

    if (g_observers[client].FindValue(observer) == VALUE_NOT_FOUND) {
        g_observers[client].Push(observer);
    }
}
