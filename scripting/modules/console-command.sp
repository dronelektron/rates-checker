void Command_Create() {
    RegAdminCmd("sm_rateschecker", Command_RatesChecker, ADMFLAG_GENERIC);
}

public Action Command_RatesChecker(int client, int args) {
    Menu_Players(client);

    return Plugin_Handled;
}
