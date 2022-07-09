void MessagePrint_PlayerHasInvalidSettings(int client, int admin) {
    CPrintToChat(admin, "%s%t", PREFIX_COLORED, "Player has invalid settings", client);
}

void MessageReply_PlayerIsNoLongerAvailable(int client) {
    ReplyToCommand(client, "%s%t", PREFIX, "Player is no longer available");
}
