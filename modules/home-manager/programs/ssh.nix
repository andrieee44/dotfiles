{ pkgs, ... }:
{
  programs.ssh = {
    package = pkgs.openssh;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      compression = true;
      addKeysToAgent = "yes";
    };
  };
}
