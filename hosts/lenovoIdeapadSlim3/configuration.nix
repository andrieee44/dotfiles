{ pkgs, ... }:
{
	imports = [ ./hardware-configuration.nix ];
	networking.hostName = "nixos";

	users.users.andrieee44 = {
		isNormalUser = true;
		shell = pkgs.zsh;

		extraGroups = [
			"audio"
			"floppy"
			"input"
			"networkmanager"
			"render"
			"video"
			"wheel"
		];
	};

	security.sudo = {
		execWheelOnly = true;
		wheelNeedsPassword = false;
	};
}
