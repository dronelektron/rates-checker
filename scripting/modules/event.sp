void Event_Create() {
    HookEvent("player_spawn", Event_PlayerSpawn);
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast) {
    int userId = event.GetInt("userid");
    int client = GetClientOfUserId(userId);
    int inAliveTeam = GetClientTeam(client) > TEAM_SPECTATOR;

    if (inAliveTeam && Variable_CheckOnSpawn()) {
        UseCase_CheckSettings(client);
    }
}
