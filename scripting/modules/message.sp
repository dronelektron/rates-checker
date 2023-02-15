void Message_PlayerKickedForInvalidType(int client, const char[] cvarName, const char[] cvarValue) {
    CPrintToChatAll("%t%t", PREFIX_COLORED, "Player kicked for invalid value type", client, cvarName, cvarValue);
    LogMessage("\"%L\" kicked for '%s' = '%s' (invalid value type)", client, cvarName, cvarValue);
}

void Message_PlayerKickedForInvalidValue(int client, const char[] cvarName, const char[] cvarValue) {
    CPrintToChatAll("%t%t", PREFIX_COLORED, "Player kicked for invalid value", client, cvarName, cvarValue);
    LogMessage("\"%L\" kicked for '%s' = '%s' (invalid value)", client, cvarName, cvarValue);
}

void Message_NoPreviousClient(int client) {
    PrintToChat(client, "%s%t", PREFIX, "No previous player");
}

void Message_NoNextClient(int client) {
    PrintToChat(client, "%s%t", PREFIX, "No next player");
}

void Message_PlayerIsNoLongerAvailable(int client) {
    PrintToChat(client, "%s%t", PREFIX, "Player is no longer available");
}
