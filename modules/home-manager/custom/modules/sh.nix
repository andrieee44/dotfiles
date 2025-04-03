{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.custom.sh = {
    lsbin = lib.mkOption { type = lib.types.package; };
    bookmarks = lib.mkOption { type = lib.types.package; };
    system = lib.mkOption { type = lib.types.package; };
    pass = lib.mkOption { type = lib.types.package; };
    man = lib.mkOption { type = lib.types.package; };
  };

  config.custom.sh =
    let
      custom = config.custom.programs;
      cmenu = "${custom.cmenu.package}/bin/cmenu";
      fzf = "${config.programs.fzf.package}/bin/fzf-tmux $FZF_TMUX_OPTS";

      cmenuFile = path: "${config.home.homeDirectory}/${config.xdg.dataFile."cmenu/${path}.json".target}";
    in
    {
      lsbin = pkgs.writers.writeDashBin "lsbin" ''
        set -eu

        bin="$(${custom.lsbin.package}/bin/lsbin | ${cmenu} \
        	'${fzf} --header " Execute Binary "')"
        eval "$bin"
      '';

      bookmarks = pkgs.writers.writeDashBin "bookmarks" ''
        set -eu

        value="$(${cmenu} \
        	'${fzf} --header "󰃀 Bookmarks 󰃀"' \
        	${cmenuFile "bookmarks"})"

        [ -n "${"\${WAYLAND_DISPLAY:-}"}" ] && ${pkgs.wl-clipboard}/bin/wl-copy "$value" && return
        [ -n "${"\${TMUX:-}"}" ] && ${config.programs.tmux.package}/bin/tmux setb "$value" && return
        ${pkgs.toybox}/bin/printf "%s" "$value"
      '';

      system = pkgs.writers.writeDashBin "system" ''
        set -eu

        eval "$(${cmenu} \
        	'${fzf} --header "󰍹 System Actions 󰍹"' \
        	${cmenuFile "system"})"
      '';

      pass =
        let
          pass = "${config.programs.password-store.package}/bin/pass";
          passDir = config.programs.password-store.settings.PASSWORD_STORE_DIR;
        in
        pkgs.writers.writeDashBin "pass" ''
          set -eu

          export PASSWORD_STORE_DIR="${passDir}"
          export GNUPGHOME="${config.programs.gpg.homedir}"

          pass="$(${pkgs.toybox}/bin/find "${passDir}" -type f -name '*.gpg' -printf '%P\n' \
          	| ${pkgs.jaq}/bin/jaq -Rs 'gsub("\\.gpg\n"; "\n") | split("\n") | del(.[-1]) | map({(.): .}) | add' \
          	| ${cmenu} \
          		'${fzf} --header "󰌆 Password Store 󰌆"')"

          ${pass} otp validate "$(${pass} otp uri "$pass" || ${pkgs.toybox}/bin/echo)" 2> /dev/null && ${pass} otp -c "$pass" || ${pass} -c "$pass"
        '';

      man = pkgs.writers.writeDashBin "man" ''
        set -eu

        eval "$(${pkgs.man}/bin/man -k '.' \
        	| ${custom.line2json.package}/bin/line2json -o -V '^(.+) \((.+)\)[[:space:]]*-.*$' -v '${pkgs.man}/bin/man $2 $1' \
        	| ${cmenu} \
        		'${fzf} --header " Man Pages "')"
      '';
    };
}
