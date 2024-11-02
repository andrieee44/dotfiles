{
  programs.direnv = {
    nix-direnv.enable = true;

    config.global = {
      disable_stdin = true;
      strict_env = true;
    };
  };
}
