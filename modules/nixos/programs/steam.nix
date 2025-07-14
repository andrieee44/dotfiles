{ pkgs, ... }:
{
  programs.steam = {
    extest.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    gamescopeSession.enable = true;
    protontricks.enable = true;

    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
      };
    };
  };
}
