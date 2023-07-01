{ config, ... }:
{
	config.services.tlp = {
		settings = {
			STOP_CHARGE_THRESH_BAT0 = 1;
			RESTORE_THRESHOLDS_ON_BAT = 1;
			BAY_POWEROFF_ON_AC = 1;
			BAY_POWEROFF_ON_BAT = 1;
			DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth wwan";
			SOUND_POWER_SAVE_ON_AC = 10;
			SOUND_POWER_SAVE_ON_BAT = 10;
		};
	};
}
