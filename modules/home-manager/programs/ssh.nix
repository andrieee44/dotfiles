{ pkgs, ... }:
{
  programs.ssh = {
    package = pkgs.openssh;
    compression = true;
  };
}
