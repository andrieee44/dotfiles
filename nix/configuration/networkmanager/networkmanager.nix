{ config, ... }:
{
	config.networking.networkmanager = {
		wifi.powersave = true;
	};
}
