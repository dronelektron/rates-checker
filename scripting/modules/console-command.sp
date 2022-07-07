void Command_Create() {
    RegAdminCmd("sm_rateschecker", Command_RatesChecker, ADMFLAG_GENERIC);
    RegAdminCmd("sm_rateschecker_refresh", Command_Refresh, ADMFLAG_GENERIC);
}

public Action Command_RatesChecker(int client, int args) {
    Menu_Players(client);

    return Plugin_Handled;
}

public Action Command_Refresh(int client, int args) {
    for (int i = 1; i <= MaxClients; i++) {
        if (IsClientInGame(i)) {
            Settings_Query(i);
        }
    }

    return Plugin_Handled;
}
