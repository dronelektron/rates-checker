static ConVar g_validationMode = null;
static ConVar g_checkOnSpawn = null;
static ConVar g_cvarLimits[Cvar_Amount];

void Variable_Create() {
    g_validationMode = CreateConVar("sm_rateschecker_validation_mode", "2", "Validation mode (disabled - 0, type - 1, type and value - 2)");
    g_checkOnSpawn = CreateConVar("sm_rateschecker_check_on_spawn", "1", "Enable (1) or disable (0) settings check on spawn");

    g_cvarLimits[Cvar_InterpMin] = CreateConVar("sm_rateschecker_interp_min", "0.0", "Minimum value of 'cl_interp'");
    g_cvarLimits[Cvar_InterpMax] = CreateConVar("sm_rateschecker_interp_max", "0.5", "Maximum value of 'cl_interp'");
    g_cvarLimits[Cvar_InterpRatioMin] = CreateConVar("sm_rateschecker_interp_ratio_min", "1.0", "Minimum value of 'cl_interp_ratio'");
    g_cvarLimits[Cvar_InterpRatioMax] = CreateConVar("sm_rateschecker_interp_ratio_max", "2.0", "Maximum value of 'cl_interp_ratio'");
    g_cvarLimits[Cvar_CmdRateMin] = CreateConVar("sm_rateschecker_cmdrate_min", "30", "Minimum value of 'cl_cmdrate'");
    g_cvarLimits[Cvar_CmdRateMax] = CreateConVar("sm_rateschecker_cmdrate_max", "66", "Maximum value of 'cl_cmdrate'");
    g_cvarLimits[Cvar_UpdateRateMin] = CreateConVar("sm_rateschecker_updaterate_min", "20", "Minimum value of 'cl_updaterate'");
    g_cvarLimits[Cvar_UpdateRateMax] = CreateConVar("sm_rateschecker_updaterate_max", "66", "Maximum value of 'cl_updaterate'");
    g_cvarLimits[Cvar_RateMin] = CreateConVar("sm_rateschecker_rate_min", "80000", "Minimum value of 'rate'");
    g_cvarLimits[Cvar_RateMax] = CreateConVar("sm_rateschecker_rate_max", "100000", "Maximum value of 'rate'");
}

int Variable_ValidationMode() {
    return g_validationMode.IntValue;
}

bool Variable_CheckOnSpawn() {
    return g_checkOnSpawn.IntValue == 1;
}

int Variable_CvarLimitInteger(int cvarIndex) {
    return g_cvarLimits[cvarIndex].IntValue;
}

float Variable_CvarLimitFloat(int cvarIndex) {
    return g_cvarLimits[cvarIndex].FloatValue;
}
