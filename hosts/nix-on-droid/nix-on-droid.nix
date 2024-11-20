{
  pkgs,
  lib,
  stateVersion,
  ...
}:
{
  time.timeZone = "Asia/Manila";
  system.stateVersion = stateVersion;
  user.shell = "${pkgs.zsh}/bin/zsh";

  terminal.font = "${
    pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; }
  }/share/fonts/truetype/NerdFonts/SauceCodeProNerdFontMono-Regular.ttf";

  nix =
    let
      builders = builtins.map (x: "ssh-ng://builder${builtins.toString x}@192.168.100.7") (lib.range 1 1);
    in
    {
      substituters = builders;

      trustedPublicKeys = [
        "builder1@lenovoIdeapadSlim3:FhBevAZRvgSE05PQ0FFw2kIuOLqhlNbtM+JcUwjvnK0="
        "builder2@lenovoIdeapadSlim3:WLWNV313efm+HRaHuF7hNLpESgxUIVmUXeI2Zpeb1sM="
      ];

      extraOptions = ''
        builders-use-substitutes = true
        experimental-features = nix-command flakes
        builders = ${builtins.concatStringsSep " " builders}
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
