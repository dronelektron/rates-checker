void Sound_Precache() {
    PrecacheSound(SOUND_MENU_ITEM, PRELOAD_YES);
    PrecacheSound(SOUND_MENU_EXIT, PRELOAD_YES);
}

void Sound_MenuItem(int client) {
    EmitSoundToClient(client, SOUND_MENU_ITEM);
}

void Sound_MenuExit(int client) {
    EmitSoundToClient(client, SOUND_MENU_EXIT);
}
