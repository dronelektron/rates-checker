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

* sm_rateschecker_notifications - Enable (1) or disable (0) notifications [default: "1"]
* sm_rateschecker_interp_min - Minimum 'cl_interp' value [default: "0.01"]
* sm_rateschecker_interp_max - Maximum 'cl_interp' value [default: "0.1"]
* sm_rateschecker_interp_ratio_min - Minimum 'cl_interp_ratio' value [default: "1.0"]
* sm_rateschecker_interp_ratio_max - Maximum 'cl_interp_ratio' value [default: "2.0"]

### Console Commands

* sm_rates - Open player rates menu
