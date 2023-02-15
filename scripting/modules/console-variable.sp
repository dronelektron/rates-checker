static ConVar g_validationMode = null;
static ConVar g_cvarLimits[Cvar_Amount];

void Variable_Create() {
    g_validationMode = CreateConVar("sm_rateschecker_validation_mode", "2");

    g_cvarLimits[Cvar_InterpMin] = CreateConVar("sm_rateschecker_interp_min", "0.0");
    g_cvarLimits[Cvar_InterpMax] = CreateConVar("sm_rateschecker_interp_max", "0.5");
    g_cvarLimits[Cvar_InterpRatioMin] = CreateConVar("sm_rateschecker_interp_ratio_min", "0.0");
    g_cvarLimits[Cvar_InterpRatioMax] = CreateConVar("sm_rateschecker_interp_ratio_max", "2.0");
    g_cvarLimits[Cvar_CmdRateMin] = CreateConVar("sm_rateschecker_cmdrate_min", "33");
    g_cvarLimits[Cvar_CmdRateMax] = CreateConVar("sm_rateschecker_cmdrate_max", "66");
    g_cvarLimits[Cvar_UpdateRateMin] = CreateConVar("sm_rateschecker_updaterate_min", "33");
    g_cvarLimits[Cvar_UpdateRateMax] = CreateConVar("sm_rateschecker_updaterate_max", "66");
    g_cvarLimits[Cvar_RateMin] = CreateConVar("sm_rateschecker_rate_min", "30000");
    g_cvarLimits[Cvar_RateMax] = CreateConVar("sm_rateschecker_rate_max", "60000");
}

int Variable_ValidationMode() {
    return g_validationMode.IntValue;
}

int Variable_CvarLimitInteger(int cvarIndex) {
    return g_cvarLimits[cvarIndex].IntValue;
}

float Variable_CvarLimitFloat(int cvarIndex) {
    return g_cvarLimits[cvarIndex].FloatValue;
}
