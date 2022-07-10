void MessagePrint_PlayerHasBadSettings(int client, int admin) {
    CPrintToChat(admin, "%s%t", PREFIX_COLORED, "Player has bad settings", client);
}

void MessagePrint_PlayerIsNoLongerAvailable(int client) {
    PrintToChat(client, "%s%t", PREFIX, "Player is no longer available");
}
