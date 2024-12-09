{ config, lib, ... }:
{
  options.stylix.targets.custom.zsh.enable =
    lib.mkEnableOption "custom implementation of styling zsh";
  config.programs.zsh.autosuggestion.highlight =
    lib.mkIf config.stylix.targets.custom.zsh.enable "$([ \"\${XDG_SESSION_TYPE:-}\" = \"tty\" ] && echo 'fg=magenta' || echo 'fg=${config.lib.stylix.colors.withHashtag.base0E}')";
}
