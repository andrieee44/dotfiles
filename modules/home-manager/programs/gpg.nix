{ config, ... }:
{
  programs.gpg = {
    homedir = "${config.xdg.dataHome}/gnupg";
    mutableKeys = false;
    mutableTrust = false;
  };
}
