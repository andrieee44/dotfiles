{
  config,
  pkgs,
  lib,
  ...
}:
lib.mkIf config.programs.lf.enable {
  programs.lf = {
    commands.open = "$$OPENER \"$f\"";

    settings =
      let
        dateGoFmt = "Jan _2 2006 (Mon) 3:04 PM";
      in
      {
        autoquit = true;
        drawbox = true;
        globsearch = true;
        hidden = true;
        icons = true;
        incfilter = true;
        infotimefmtnew = dateGoFmt;
        infotimefmtold = dateGoFmt;
        number = true;
        relativenumber = true;
        shell = "${pkgs.dash}/bin/dash";
        shellopts = "-eu";
        sixel = true;
        tabstop = 4;
        timefmt = dateGoFmt;
        waitmsg = "Press any key to continue...";
        wrapscroll = true;

        previewer = lib.mkIf config.custom.programs.tview.enable (
          builtins.toString (
            pkgs.writers.writeDash "tviewlf" ''
              set -eu; ${config.custom.programs.tview.package}/bin/tview -w "$2" -h "$3" "$1"
            ''
          )
        );
      };
  };

  xdg.configFile = {
    "lf/guiIcons".source = ./guiIcons;
    "lf/ttyIcons".source = ./ttyIcons;
  };

  home = {
    packages = [ pkgs.ncurses ];

    shellAliases =
      let
        lf = builtins.toString (
          pkgs.writers.writeDash "lfConf" ''
            set -eu

            [ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] && \
            	${pkgs.toybox}/bin/cat "${config.home.homeDirectory}/${
               config.xdg.configFile."lf/ttyIcons".target
             }" > "${config.xdg.configHome}/lf/icons" || \
            	${pkgs.toybox}/bin/cat "${config.home.homeDirectory}/${
               config.xdg.configFile."lf/guiIcons".target
             }" > "${config.xdg.configHome}/lf/icons"

            ${config.programs.lf.package}/bin/lf "$@"
          ''
        );
      in
      {
        lf = lf;
        lfcd = ''lfcd() { cd "$(${lf} -print-last-dir "$@")" }; lfcd'';
      };
  };
}
