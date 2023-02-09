void Command_Create() {
    RegConsoleCmd("sm_rates", Command_Rates);
}

public Action Command_Rates(int client, int args) {
    Menu_Players(client);

    return Plugin_Handled;
}
