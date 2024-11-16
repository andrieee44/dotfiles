{ pkgs, stateVersion, ... }:
{
  time.timeZone = "Asia/Manila";
  system.stateVersion = stateVersion;
  user.shell = "${pkgs.zsh}/bin/zsh";
  terminal.font = "${
    pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; }
  }/share/fonts/truetype/NerdFonts/SauceCodeProNerdFontMono-Regular.ttf";

  nix.extraOptions = ''
    builders-use-substitutes = true
    builders = ssh-ng://nix-on-droid@192.168.100.7
    experimental-features = nix-command flakes
  '';

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
