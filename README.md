# Rates checker

Allows you to check player rates:

* cl_interp
* cl_interp_ratio
* cl_cmdrate
* cl_updaterate
* rate

### Supported Games

* Day of Defeat: Source

### Installation

* Download latest [release](https://github.com/dronelektron/rates-checker/releases) (compiled for SourceMod 1.11)
* Extract "plugins" and "translations" folders to "addons/sourcemod" folder of your server

### Console Variables

* sm_rateschecker_validation_mode - Validation mode (disabled - 0, type - 1, type and value - 2) [default: "2"]
* sm_rateschecker_check_on_spawn - Enable (1) or disable (0) settings check on spawn [default: "1"]
* sm_rateschecker_interp_min - "Minimum value of 'cl_interp'" [default: "0.0"]
* sm_rateschecker_interp_max - "Maximum value of 'cl_interp'" [default: "0.5"]
* sm_rateschecker_interp_ratio_min - "Minimum value of 'cl_interp_ratio'" [default: "1.0"]
* sm_rateschecker_interp_ratio_max - "Maximum value of 'cl_interp_ratio'" [default: "2.0"]
* sm_rateschecker_cmdrate_min - "Minimum value of 'cl_cmdrate'" [default: "30"]
* sm_rateschecker_cmdrate_max - "Maximum value of 'cl_cmdrate'" [default: "66"]
* sm_rateschecker_updaterate_min - "Minimum value of 'cl_updaterate'" [default: "20"]
* sm_rateschecker_updaterate_max - "Maximum value of 'cl_updaterate'" [default: "66"]
* sm_rateschecker_rate_min - "Minimum value of 'rate'" [default: "80000"]
* sm_rateschecker_rate_max - "Maximum value of 'rate'" [default: "100000"]

### Console Commands

* sm_rates [#userid|name] - Open menu with all players or specified
