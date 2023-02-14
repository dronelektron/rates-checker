static Regex g_intRegex = null;
static Regex g_floatRegex = null;

void Validator_Create() {
    g_intRegex = CompileRegex("^(0|[1-9][0-9]*)$");
    g_floatRegex = CompileRegex("^((0|[1-9][0-9]*)(\\.[0-9]+)?|\\.[0-9]+)$");
}

void Validator_Destroy() {
    delete g_intRegex;
    delete g_floatRegex;
}

bool Validator_IsInt(const char[] value) {
    int matches = g_intRegex.Match(value);

    return matches > NO_MATCHES;
}

bool Validator_IsFloat(const char[] value) {
    int matches = g_floatRegex.Match(value);
    
    return matches > NO_MATCHES;
}
