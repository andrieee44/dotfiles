{ pkgs, stateVersion, ... }:
{
	time.timeZone = "Asia/Manila";
	system.stateVersion = stateVersion;
	nix.extraOptions = "experimental-features = nix-command flakes";
	user.shell = "${pkgs.zsh}/bin/zsh";
	terminal.font = "${pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; }}/share/fonts/truetype/NerdFonts/SauceCodeProNerdFontMono-Regular.ttf";

	environment = {
		motd = "";
		sessionVariables.XDG_SESSION_TYPE = "tty";
	};

	android-integration = {
		termux-open.enable = true;
		termux-open-url.enable = true;
		termux-reload-settings.enable = true;
		termux-setup-storage.enable = true;
		termux-wake-lock.enable = true;
		termux-wake-unlock.enable = true;
		xdg-open.enable = true;
	};
}
