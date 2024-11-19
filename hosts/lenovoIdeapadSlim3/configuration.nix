{ pkgs, lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "lenovoIdeapadSlim3";
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.trusted-users = [ "@builders" ];

  users = {
    groups.builders = { };

    users =
      let
        builder = {
          createHome = true;
          group = "builders";
          isNormalUser = true;
          shell = pkgs.zsh;

          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDJtUQ3XeEdvcpvQp4DkLPiskGmNzW4+STtNOM1k4aGZ nix-on-droid@oppoReno8Z"
          ];
        };
      in
      (lib.genAttrs (builtins.map (x: "builder${builtins.toString x}") (lib.range 1 2)) (key: builder))
      // {
        andrieee44 = {
          createHome = true;
          group = "users";
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
      };
  };
}
