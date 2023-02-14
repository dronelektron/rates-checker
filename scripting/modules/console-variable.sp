static ConVar g_validationMode = null;

void Variable_Create() {
    g_validationMode = CreateConVar("sm_rateschecker_validation_mode", "1");
}

int Variable_ValidationMode() {
    return g_validationMode.IntValue;
}
