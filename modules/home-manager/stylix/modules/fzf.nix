{ config, lib, ... }:
{
  options.stylix.targets.custom.fzf.enable =
    lib.mkEnableOption "custom implementation of styling fzf";

  config.programs.fzf.colors =
    lib.mkIf (config.programs.fzf.enable && config.stylix.targets.custom.fzf.enable)
      {
        fg = "white";
        hl = "blue";
        "fg+" = "bright-white";
        "bg+" = "black";
        info = "yellow";
        border = "blue";
        prompt = "yellow";
        pointer = "cyan";
        marker = "cyan";
        spinner = "cyan";
        header = "blue";
      };
}
