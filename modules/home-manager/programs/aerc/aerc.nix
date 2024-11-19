{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg.configFile."aerc/gui.conf".source = lib.mkIf config.programs.aerc.enable ./gui.conf;

  programs.aerc.extraConfig = {
    filters."text/plain" = "colorize";

    general = {
      term = "linux";
      unsafe-accounts-conf = true;
    };

    ui =
      let
        dateGoFmt = "Jan _2 2006 (Mon) 3:04 PM";
      in
      {
        border-char-vertical = "│";
        border-char-horizontal = "─";
        timestamp-format = dateGoFmt;
        this-day-time-format = "";
        this-week-time-format = "";
        this-year-time-format = "";
        message-view-timestamp-format = dateGoFmt;
        dirlist-delay = "0s";
        styleset-name = "gui";
        fuzzy-complete = true;
        threading-enabled = true;
        show-thread-context = true;
        icon-unencrypted = "e?";
        icon-encrypted = "e";
        icon-signed = "s";
        icon-signed-encrypted = "se";
        icon-unknown = "?";
        icon-invalid = "X";
        thread-prefix-tip = "";
        thread-prefix-indent = "";
        thread-prefix-stem = "│";
        thread-prefix-limb = "─";
        thread-prefix-folded = "+";
        thread-prefix-unfolded = "";
        thread-prefix-first-child = "┬";
        thread-prefix-has-siblings = "├";
        thread-prefix-orphan = "┌";
        thread-prefix-dummy = "┬";
        thread-prefix-lone = " ";
        thread-prefix-last-sibling = "╰";
      };

    viewer = {
      pager = config.home.sessionVariables.PAGER;
      show-headers = true;
      always-show-mime = true;
    };

    compose = {
      editor = config.home.sessionVariables.EDITOR;
      empty-subject-warning = true;
      format-flowed = true;
    };
  };

  home = lib.mkIf config.programs.aerc.enable {
    file."${config.xdg.configHome}/aerc/aerc.conf".target = "${config.xdg.configHome}/aerc/tty.conf";

    shellAliases.aerc = builtins.toString (
      pkgs.writers.writeDash "aercConf" ''
        set -eu

        ${pkgs.gawk}/bin/awk -v term="${"\${TERM}"}" -v tty="${"\${XDG_SESSION_TYPE:-}"}" '{
        	sub("term = .*", "term = " term)

        	if (tty == "tty") {
        		sub("styleset-name = gui", "styleset-name = tty")
        	}

        	print($0)
        }' "${config.home.homeDirectory}/${
          config.home.file."${config.xdg.configHome}/aerc/aerc.conf".target
        }" > "${config.xdg.configHome}/aerc/aerc.conf"

        [ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] || \
        	${pkgs.toybox}/bin/cat "${config.home.homeDirectory}/${
           config.xdg.configFile."aerc/gui.conf".target
         }" >> "${config.xdg.configHome}/aerc/aerc.conf"

        ${pkgs.toybox}/bin/chmod 0600 "${config.xdg.configHome}/aerc/aerc.conf"

        ${config.programs.aerc.package}/bin/aerc "$@"
      ''
    );
  };
}
