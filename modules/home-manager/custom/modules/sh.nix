{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.custom.sh = {
    bookmarks = lib.mkOption { type = lib.types.package; };
    system = lib.mkOption { type = lib.types.package; };
    pass = lib.mkOption { type = lib.types.package; };
    man = lib.mkOption { type = lib.types.package; };
  };

  config.custom.sh = {
    bookmarks = pkgs.writers.writeDashBin "bookmarks" ''
      set -eu

      value="$(${config.custom.programs.cmenu.package}/bin/cmenu \
      	'${config.programs.fzf.package}/bin/fzf-tmux -p "50%,50%" --header "󰃀 Bookmarks 󰃀"' \
      	${config.home.homeDirectory}/${config.xdg.dataFile."cmenu/bookmarks.json".target})"

      [ -n "${"\${WAYLAND_DISPLAY:-}"}" ] && ${pkgs.wl-clipboard}/bin/wl-copy "$value" && return
      [ -n "${"\${TMUX:-}"}" ] && ${config.programs.tmux.package}/bin/tmux setb "$value" && return
      printf "%s" "$value"
    '';

    system = pkgs.writers.writeDashBin "system" ''
      set -eu

      eval "$(${config.custom.programs.cmenu.package}/bin/cmenu \
      	'${config.programs.fzf.package}/bin/fzf-tmux -p "50%,50%" --header "󰍹 System Actions 󰍹"' \
      	${config.home.homeDirectory}/${config.xdg.dataFile."cmenu/system.json".target})"
    '';

    pass = pkgs.writers.writeDashBin "pass" ''
      set -eu

      PASSWORD_STORE_DIR="${config.programs.password-store.settings.PASSWORD_STORE_DIR}" GNUPGHOME="${config.programs.gpg.homedir}" ${config.programs.password-store.package}/bin/pass \
      	-c "$(${pkgs.toybox}/bin/find "${config.programs.password-store.settings.PASSWORD_STORE_DIR}" -type f -name '*.gpg' -printf '%P\n' \
      		| ${pkgs.jaq}/bin/jaq -Rs 'gsub("\\.gpg\n"; "\n") | split("\n") | del(.[-1]) | map({(.): .}) | add' \
      		| ${config.custom.programs.cmenu.package}/bin/cmenu \
      			'${config.programs.fzf.package}/bin/fzf-tmux -p "50%,50%" --header "󰌆 Password Store 󰌆"')"
    '';

    man = pkgs.writers.writeDashBin "man" ''
      set -eu

      eval "$(${pkgs.man}/bin/man -k '.' \
      	| ${config.custom.programs.line2json.package}/bin/line2json -o -V '^(.+) \((.+)\)[[:space:]]*-.*$' -v 'man $2 $1' \
      	| ${config.custom.programs.cmenu.package}/bin/cmenu \
      		'${config.programs.fzf.package}/bin/fzf-tmux -p "50%,50%" --header " Man Pages "')"
    '';
  };
}
