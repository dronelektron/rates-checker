void Message_NoPreviousClient(int client) {
    PrintToChat(client, "%s%t", PREFIX, "No previous player");
}

void Message_NoNextClient(int client) {
    PrintToChat(client, "%s%t", PREFIX, "No next player");
}

void Message_PlayerIsNoLongerAvailable(int client) {
    PrintToChat(client, "%s%t", PREFIX, "Player is no longer available");
}
