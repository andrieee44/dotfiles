{ pkgs, stateVersion, ... }:
{
	android-integration = {
		termux-open.enable = true;
		termux-open-url.enable = true;
		termux-reload-settings.enable = true;
		termux-setup-storage.enable = true;
		termux-wake-lock.enable = true;
		termux-wake-unlock.enable = true;
		xdg-open.enable = true;
	};
	
	environment = {
		packages = with pkgs; [
			home-manager
			git
		];
		
		motd = "";
	};
	
	time.timeZone = "Asia/Manila";
	system.stateVersion = stateVersion;
	nix.extraOptions = "experimental-features = nix-command flakes";
}