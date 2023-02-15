void Event_Create() {
    HookEvent("player_spawn", Event_PlayerSpawn);
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
    if (!Variable_CheckOnSpawn()) {
        return;
    }

    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);

    UseCase_CheckSettings(client);
}
