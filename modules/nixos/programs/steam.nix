{ pkgs, ... }:
{
  programs.steam = {
    extest.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    protontricks.enable = true;

    gamescopeSession = {
      enable = true;

      args = [
        "-W 1920"
        "-H 1080"
        "-r 60"
        "-h 480"
        "-F fsr"
        "--backend sdl"
        "--expose-wayland"
        "--mangoapp"
      ];
    };
  };
}
