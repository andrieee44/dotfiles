{ ... }:
{
	config.services.tlp = {
		settings = {
			BAY_POWEROFF_ON_AC = 1;
			BAY_POWEROFF_ON_BAT = 1;
			CPU_ENERGY_PERC_POLICY_ON_AC = "performance";
			CPU_ENERGY_PERC_POLICY_ON_BAT = "power";
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
			DEVICES_TO_DISABLE_ON_STARTUP = "wifi bluetooth wwan";
			RESTORE_THRESHOLDS_ON_BAT = 1;
			SOUND_POWER_SAVE_ON_BAT = 10;
			STOP_CHARGE_THRESH_BAT0 = 1;
		};
	};
}
