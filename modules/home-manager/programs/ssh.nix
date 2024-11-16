{ pkgs, ... }:
{
  programs.ssh = {
    package = pkgs.openssh;
    addKeysToAgent = "yes";
    compression = true;
  };
}
