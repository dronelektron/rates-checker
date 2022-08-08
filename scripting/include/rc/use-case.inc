#if defined _rc_use_case_included
 #endinput
#endif
#define _rc_use_case_included

#define REQUEST_CODE "code"
#define REQUEST_CLIENT "client"
#define REQUEST_TARGET "target"

enum {
    RequestCode_NotFound = -1,
    RequestCode_CheckSettings,
    RequestCode_RefreshSettings
};
