void Menu_Players(int client) {
    Menu menu = new Menu(MenuHandler_Players);

    menu.SetTitle(RATES_CHECKER);

    Menu_AddPlayers(menu);

    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Players(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[USER_ID_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int userId = StringToInt(info);
        int target = GetClientOfUserId(userId);

        if (target == 0) {
            // TODO: Message

            return 0;
        }

        Menu_PlayerRates(param1, target);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_PlayerRates(int client, int target) {
    Menu menu = new Menu(MenuHandler_PlayerRates);

    menu.SetTitle("%N", target);

    Menu_AddConsoleVariableItem(menu, CONSOLE_VARIABLE_INTERP, target);
    Menu_AddConsoleVariableItem(menu, CONSOLE_VARIABLE_CMD_RATE, target);
    Menu_AddConsoleVariableItem(menu, CONSOLE_VARIABLE_UPDATE_RATE, target);
    Menu_AddConsoleVariableItem(menu, CONSOLE_VARIABLE_RATE, target);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_PlayerRates(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_Players(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_AddPlayers(Menu menu) {
    char info[USER_ID_MAX_SIZE];
    char item[PLAYER_NAME_MAX_SIZE];

    for (int i = 1; i < MaxClients; i++) {
        if (!IsClientInGame(i)) {
            continue;
        }

        int userId = GetClientUserId(i);

        IntToString(userId, info, sizeof(info));
        GetClientName(i, item, sizeof(item));

        menu.AddItem(info, item);
    }
}

void Menu_AddConsoleVariableItem(Menu menu, const char[] consoleVariable, int target) {
    char value[CONSOLE_VARIABLE_MAX_SIZE];
    char item[ITEM_MAX_SIZE];

    Settings_Get(target, consoleVariable, value);
    Format(item, sizeof(item), "%s = %s", consoleVariable, value);

    menu.AddItem("", item);
}
