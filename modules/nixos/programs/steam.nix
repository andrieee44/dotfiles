{ pkgs, ... }:
{
  programs.steam = {
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
    gamescopeSession.enable = true;
    extest.enable = true;
    protontricks.enable = true;

    package = pkgs.steam.override {
      extraEnv = {
        MANGOHUD = true;
      };
    };
  };
}
