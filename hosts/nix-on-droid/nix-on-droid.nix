{ pkgs, stateVersion, ... }:
{
  time.timeZone = "Asia/Manila";
  system.stateVersion = stateVersion;
  user.shell = "${pkgs.zsh}/bin/zsh";
  terminal.font = "${pkgs.nerd-fonts.sauce-code-pro}/share/fonts/truetype/NerdFonts/SauceCodePro/SauceCodeProNerdFontMono-Regular.ttf";

  nix = {
    trustedPublicKeys = [ "builder@lenovoIdeapadSlim3:FhBevAZRvgSE05PQ0FFw2kIuOLqhlNbtM+JcUwjvnK0=" ];

    extraOptions = ''
      builders-use-substitutes = true
      experimental-features = nix-command flakes
      builders = ssh-ng://builder@192.168.1.101
    '';
  };

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
