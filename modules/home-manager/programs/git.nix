{ config, ... }:
{
  programs.git = {
    userName = config.home.username;
    signing.signByDefault = true;
  };
}
