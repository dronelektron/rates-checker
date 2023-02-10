void Command_Create() {
    RegConsoleCmd("sm_rates", Command_Rates);
}

public Action Command_Rates(int client, int args) {
    if (args < 1) {
        Menu_Players(client);
    } else {
        char name[MAX_NAME_LENGTH];

        GetCmdArg(1, name, sizeof(name));

        int target = FindTarget(client, name);

        if (target != CLIENT_NOT_FOUND) {
            Menu_Rates(client, target);
        }
    }

    return Plugin_Handled;
}
