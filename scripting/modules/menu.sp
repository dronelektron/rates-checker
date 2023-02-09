static int g_lastTargetId[MAXPLAYERS + 1];

void Menu_Players(int client) {
    Menu menu = new Menu(MenuHandler_Players);

    menu.SetTitle("%T", TITLE_RATES_CHECKER, client);

    Menu_AddPlayers(menu);

    menu.Display(client, MENU_TIME_FOREVER);
}

public int MenuHandler_Players(Menu menu, MenuAction action, int param1, int param2) {
    if (action == MenuAction_Select) {
        char info[INFO_SIZE];

        menu.GetItem(param2, info, sizeof(info));

        int userId = StringToInt(info);
        int target = GetClientOfUserId(userId);

        if (target == INVALID_CLIENT) {
            Menu_Players(param1);
            Message_PlayerIsNoLongerAvailable(param1);
        } else {
            Settings_Query(param1, target);
        }
    } else if (action == MenuAction_End) {
        delete menu;
    }

    return 0;
}

void Menu_Rates(int client, int target) {
    Panel panel = new Panel();

    Menu_SetTitle(panel, "%T", TITLE_PLAYER_RATES, client, target);
    Menu_AddSpacer(panel);
    Menu_AddConsoleVariable(panel, client, CVAR_CL_INTERP);
    Menu_AddConsoleVariable(panel, client, CVAR_CL_INTERP_RATIO);
    Menu_AddConsoleVariable(panel, client, CVAR_CL_CMD_RATE);
    Menu_AddConsoleVariable(panel, client, CVAR_CL_UPDATE_RATE);
    Menu_AddConsoleVariable(panel, client, CVAR_RATE);
    Menu_AddSpacer(panel);
    Menu_AddNavigation(panel, client);
    Menu_AddSpacer(panel);
    Menu_AddBackButton(panel, client);
    Menu_AddExitButton(panel, client);

    g_lastTargetId[client] = GetClientUserId(target);
    panel.Send(client, MenuHandler_Rates, MENU_TIME_FOREVER);

    delete panel;
}

public int MenuHandler_Rates(Menu menu, MenuAction action, int param1, int param2) {
    if (action != MenuAction_Select) {
        return 0;
    }

    if (param2 == KEY_PLAYER_PREV) {
        MenuHandler_PreviousClient(param1);
    } else if (param2 == KEY_PLAYER_NEXT) {
        MenuHandler_NextClient(param1);
    } else if (param2 == KEY_BACK) {
        Menu_Players(param1);
    }

    if (param2 == KEY_EXIT) {
        Sound_MenuExit(param1);
    } else {
        Sound_MenuItem(param1);
    }

    return 0;
}

void MenuHandler_PreviousClient(int client) {
    int lastTarget = GetClientOfUserId(g_lastTargetId[client]);

    if (lastTarget == INVALID_CLIENT) {
        Menu_Players(client);
        Message_PlayerIsNoLongerAvailable(client);

        return;
    }

    int target = UseCase_FindPreviousClient(lastTarget);

    if (target == CLIENT_NOT_FOUND) {
        Menu_Rates(client, lastTarget);
        Message_NoPreviousClient(client);
    } else {
        Settings_Query(client, target);
    }
}

void MenuHandler_NextClient(int client) {
    int lastTarget = GetClientOfUserId(g_lastTargetId[client]);

    if (lastTarget == INVALID_CLIENT) {
        Menu_Players(client);
        Message_PlayerIsNoLongerAvailable(client);

        return;
    }

    int target = UseCase_FindNextClient(lastTarget);

    if (target == CLIENT_NOT_FOUND) {
        Menu_Rates(client, lastTarget);
        Message_NoNextClient(client);
    } else {
        Settings_Query(client, target);
    }
}

void Menu_AddPlayers(Menu menu) {
    for (int client = 1; client <= MaxClients; client++) {
        if (IsClientInGame(client)) {
            int userId = GetClientUserId(client);
            char info[INFO_SIZE];
            char item[MAX_NAME_LENGTH];

            IntToString(userId, info, sizeof(info));
            Format(item, sizeof(item), "%N", client);

            menu.AddItem(info, item);
        }
    }
}

void Menu_SetTitle(Panel panel, const char[] format, any ...) {
    char title[TITLE_SIZE];

    VFormat(title, sizeof(title), format, 3);

    panel.SetTitle(title);
}

void Menu_AddConsoleVariable(Panel panel, int client, const char[] cvarName) {
    char item[ITEM_SIZE];
    char cvarValue[CVAR_VALUE_SIZE];

    Settings_Get(client, cvarName, cvarValue);
    Format(item, sizeof(item), "%s \"%s\"", cvarName, cvarValue);

    panel.DrawText(item);
}

void Menu_AddSpacer(Panel panel) {
    panel.DrawText(" ");
}

void Menu_AddNavigation(Panel panel, int client) {
    Menu_AddItem(panel, KEY_PLAYER_PREV, "%T", ITEM_PLAYER_PREV, client);
    Menu_AddItem(panel, KEY_PLAYER_NEXT, "%T", ITEM_PLAYER_NEXT, client);
}

void Menu_AddBackButton(Panel panel, int client) {
    Menu_AddItem(panel, KEY_BACK, "%T", ITEM_BACK, client);
}

void Menu_AddExitButton(Panel panel, int client) {
    Menu_AddItem(panel, KEY_EXIT, "%T", ITEM_EXIT, client);
}

void Menu_AddItem(Panel panel, int key, const char[] format, any ...) {
    char item[ITEM_SIZE];

    VFormat(item, sizeof(item), format, 4);

    panel.CurrentKey = key;
    panel.DrawItem(item);
}
