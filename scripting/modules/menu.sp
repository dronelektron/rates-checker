static int g_lastUserId[MAXPLAYERS + 1];

void Menu_Players(int client) {
    Menu menu = new Menu(MenuHandler_Players);

    menu.SetTitle("%T", RATES_CHECKER, client);

    Menu_AddPlayers(menu);

    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Players(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[USER_ID_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));
        g_lastUserId[param1] = StringToInt(info);

        Menu_LastPlayerRates(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_LastPlayerRates(int client) {
    int userId = g_lastUserId[client];
    int target = GetClientOfUserId(userId);

    if (target == INVALID_CLIENT) {
        Menu_Players(client);
        MessagePrint_PlayerIsNoLongerAvailable(client);
    } else {
        Menu_PlayerRates(client, target);
    }
}

void Menu_PlayerRates(int client, int target) {
    Menu menu = new Menu(MenuHandler_PlayerRates);

    menu.SetTitle("%T", PLAYER_RATES, client, target);

    Menu_AddPlayerRateItem(menu, client, target, CONSOLE_VARIABLE_INTERP);
    Menu_AddPlayerRateItem(menu, client, target, CONSOLE_VARIABLE_INTERP_RATIO);
    Menu_AddPlayerRateItem(menu, client, target, CONSOLE_VARIABLE_CMD_RATE);
    Menu_AddPlayerRateItem(menu, client, target, CONSOLE_VARIABLE_UPDATE_RATE);
    Menu_AddPlayerRateItem(menu, client, target, CONSOLE_VARIABLE_RATE);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_PlayerRates(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[USER_ID_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        Menu_ServerRates(param1, info);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_Players(param1);
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_ServerRates(int client, const char[] consoleVariable) {
    Menu menu = new Menu(MenuHandler_ServerRates);

    menu.SetTitle("%T", SERVER_RATES, client, consoleVariable);

    Menu_AddServerRateItem(menu, client, consoleVariable);

    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_ServerRates(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[USER_ID_MAX_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        Menu_ServerRates(param1, info);
    } else if (action == MenuAction_Cancel && param2 == MenuCancel_ExitBack) {
        Menu_LastPlayerRates(param1);
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

void Menu_AddPlayerRateItem(Menu menu, int client, int target, const char[] consoleVariable) {
    char value[CONSOLE_VARIABLE_MAX_SIZE];
    char item[ITEM_MAX_SIZE];
    bool isValid = UseCase_CheckSettingsByName(target, consoleVariable);

    Settings_Get(target, consoleVariable, value);
    Format(item, sizeof(item), "%s %s [ %T ]", consoleVariable, value, isValid ? RATE_VALUE_GOOD : RATE_VALUE_BAD, client);

    menu.AddItem(consoleVariable, item);
}

void Menu_AddServerRateItem(Menu menu, int client, const char[] consoleVariable) {
    char minValue[CONSOLE_VARIABLE_MAX_SIZE];
    char maxValue[CONSOLE_VARIABLE_MAX_SIZE];
    char minItem[ITEM_MAX_SIZE];
    char maxItem[ITEM_MAX_SIZE];

    Variable_GetByName(consoleVariable, minValue, MIN_VALUE_YES);
    Variable_GetByName(consoleVariable, maxValue, MIN_VALUE_NO);
    Format(minItem, sizeof(minItem), "%T", MINIMUM, client, minValue);
    Format(maxItem, sizeof(maxItem), "%T", MAXIMUM, client, maxValue);

    menu.AddItem(consoleVariable, minItem);
    menu.AddItem(consoleVariable, maxItem);
}
