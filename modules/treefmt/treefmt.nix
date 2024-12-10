{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt = {
      enable = true;
      package = pkgs.nixfmt-rfc-style;
    };
  };

  settings.formatter = {
    nixfmt.options = [ "-s" ];
  };
}
