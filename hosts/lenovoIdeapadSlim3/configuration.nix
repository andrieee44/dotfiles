{ pkgs, ... }:
{
	imports = [ ./hardware-configuration.nix ];

	networking.hostName = "nixos";
	services.flatpak.enable = true;
	xdg.portal.enable = true;

	users.users.andrieee44 = {
		isNormalUser = true;
		shell = pkgs.zsh;

		extraGroups = [
			"networkmanager"
			"wheel"
			"audio"
			"video"
			"input"
			"floppy"
			"render"
		];
	};

	programs = {
		steam.enable = true;
		gamemode.enable = true;
	};

	security.sudo = {
		wheelNeedsPassword = false;
		execWheelOnly = true;
	};

	hardware = {
		bluetooth.enable = true;
		opengl.enable = true;
	};
}
