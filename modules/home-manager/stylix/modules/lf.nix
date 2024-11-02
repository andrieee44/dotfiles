{ config, lib, ... }:
{
  options.stylix.targets.custom.lf.enable = lib.mkEnableOption "custom implementation of styling lf";

  config.programs.lf.settings = lib.mkIf config.stylix.targets.custom.lf.enable {
    borderfmt = "\\033[0;34m";
    errorfmt = "\\033[1;30;41m";
    cursorparentfmt = "\\033[4m";
    promptfmt = "\\033[1;31m[\\033[1;34m%u\\033[1;33m@\\033[1;36m%h \\033[1;35m%d\\033[1;31m]\\033[0m";
    statfmt = "%p| %c| %u| %g| %S| %t| -> %l";
  };
}
