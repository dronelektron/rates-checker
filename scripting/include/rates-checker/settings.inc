#if defined _rates_checker_settings_included
 #endinput
#endif
#define _rates_checker_settings_included

#define CVAR_NAME_SIZE 16
#define CVAR_VALUE_SIZE 16

enum QueryType {
    QueryType_Menu,
    QueryType_Validation
};

enum ValueType {
    ValueType_Int,
    ValueType_Float
};
