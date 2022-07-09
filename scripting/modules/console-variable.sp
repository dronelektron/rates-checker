static ConVar g_isNotificationsEnabled = null;
static ConVar g_minInterp = null;
static ConVar g_maxInterp = null;
static ConVar g_minInterpRatio = null;
static ConVar g_maxInterpRatio = null;
static ConVar g_minCmdRate = null;
static ConVar g_maxCmdRate = null;
static ConVar g_minUpdateRate = null;
static ConVar g_maxUpdateRate = null;
static ConVar g_minRate = null;
static ConVar g_maxRate = null;

void Variable_Create() {
    g_isNotificationsEnabled = CreateConVar("sm_rateschecker_notifications", "1", "Enable (1) or disable (0) notifications");
    g_minInterp = CreateConVar("sm_rateschecker_interp_min", "0.01", "Minimum 'cl_interp' value");
    g_maxInterp = CreateConVar("sm_rateschecker_interp_max", "0.1", "Maximum 'cl_interp' value");
    g_minInterpRatio = CreateConVar("sm_rateschecker_interp_ratio_min", "1.0", "Minimum 'cl_interp_ratio' value");
    g_maxInterpRatio = CreateConVar("sm_rateschecker_interp_ratio_max", "2.0", "Maximum 'cl_interp_ratio' value");
    g_minCmdRate = FindConVar("sv_mincmdrate");
    g_maxCmdRate = FindConVar("sv_maxcmdrate");
    g_minUpdateRate = FindConVar("sv_minupdaterate");
    g_maxUpdateRate = FindConVar("sv_maxupdaterate");
    g_minRate = FindConVar("sv_minrate");
    g_maxRate = FindConVar("sv_maxrate");
}

bool Variable_IsNotificationsEnabled() {
    return g_isNotificationsEnabled.IntValue == 1;
}

float Variable_GetMinInterp() {
    return g_minInterp.FloatValue;
}

float Variable_GetMaxInterp() {
    return g_maxInterp.FloatValue;
}

float Variable_GetMinInterpRatio() {
    return g_minInterpRatio.FloatValue;
}

float Variable_GetMaxInterpRatio() {
    return g_maxInterpRatio.FloatValue;
}

int Variable_GetMinCmdRate() {
    return g_minCmdRate.IntValue;
}

int Variable_GetMaxCmdRate() {
    return g_maxCmdRate.IntValue;
}

int Variable_GetMinUpdateRate() {
    return g_minUpdateRate.IntValue;
}

int Variable_GetMaxUpdateRate() {
    return g_maxUpdateRate.IntValue;
}

int Variable_GetMinRate() {
    return g_minRate.IntValue;
}

int Variable_GetMaxRate() {
    return g_maxRate.IntValue;
}

void Variable_GetByName(const char[] consoleVariable, char[] value, bool isMinValue) {
    if (StrEqual(consoleVariable, CONSOLE_VARIABLE_INTERP)) {
        if (isMinValue) {
            g_minInterp.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        } else {
            g_maxInterp.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        }
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_INTERP_RATIO)) {
        if (isMinValue) {
            g_minInterpRatio.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        } else {
            g_maxInterpRatio.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        }
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_CMD_RATE)) {
        if (isMinValue) {
            g_minCmdRate.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        } else {
            g_maxCmdRate.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        }
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_UPDATE_RATE)) {
        if (isMinValue) {
            g_minUpdateRate.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        } else {
            g_maxUpdateRate.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        }
    } else if (StrEqual(consoleVariable, CONSOLE_VARIABLE_RATE)) {
        if (isMinValue) {
            g_minRate.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        } else {
            g_maxRate.GetString(value, CONSOLE_VARIABLE_MAX_SIZE);
        }
    } else {
        ThrowError("Invalid console variable");
    }
}
