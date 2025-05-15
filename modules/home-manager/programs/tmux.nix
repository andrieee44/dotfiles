{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs =
    let
      tmux = "${config.programs.tmux.package}/bin/tmux";
    in
    {
      tmux = {
        baseIndex = 1;
        clock24 = false;
        escapeTime = 0;
        historyLimit = 5000;
        keyMode = "vi";
        mouse = false;
        sensibleOnTop = false;

        extraConfig =
          let
            guiBool = "#{!=:${"\${XDG_SESSION_TYPE}"},tty}";
            baseIndex = builtins.toString config.programs.tmux.baseIndex;
            nextIndex = builtins.toString (config.programs.tmux.baseIndex + 1);
            customSh = script: "${config.custom.sh.${script}}/bin/${script}";

            mvpane =
              window:
              let
                windowStr = builtins.toString window;
              in
              "${tmux} breakp -t :${windowStr} || ${tmux} joinp -bt :${windowStr}.${baseIndex} && ${tmux} selectl main-vertical && ${tmux} selectl -t ':!' main-vertical || true";
          in
          ''
            %if "${guiBool}"
            	set -g default-terminal tmux-256color
            	set -sa terminal-features ",${"\${TERM}"}:RGB"
            %else
            	set -g default-terminal screen-16color
            	bind -n C-V pasteb
            %endif

            set -g focus-events on
            set -g set-clipboard on
            set -g main-pane-width 50%
            set -g window-status-separator ""
            set -g status on
            set -g status-left-length 80
            set -g status-right-length 80

            bind -n M-Enter {
            	splitw -t :.${baseIndex}
            	swapp -s :.${baseIndex} -t :.${nextIndex}
            	selectl main-vertical
            }

            bind -n M-h run 'w="$(${tmux} display -p "#{main-pane-width}")" && ${tmux} set -g main-pane-width "$((${"\${w%%%}"} - 2))%" && ${tmux} selectl main-vertical'
            bind -n M-j selectp -t :.+
            bind -n M-k selectp -t :.-
            bind -n M-l run 'w="$(${tmux} display -p "#{main-pane-width}")" && ${tmux} set -g main-pane-width "$((${"\${w%%%}"} + 2))%" && ${tmux} selectl main-vertical'
            bind -n M-Space run '[ "$(${tmux} display -p "#P")" = "${baseIndex}" ] && ${tmux} swapp -s :.${nextIndex} || ${tmux} swapp -s :.${baseIndex}'

            bind -n M-q {
            	killp
            	selectl main-vertical
            }

            bind -n M-! run '${mvpane 1}'
            bind -n M-@ run '${mvpane 2}'
            bind -n M-# run '${mvpane 3}'
            bind -n M-$ run '${mvpane 4}'
            bind -n M-% run '${mvpane 5}'
            bind -n M-^ run '${mvpane 6}'
            bind -n M-& run '${mvpane 7}'
            bind -n M-* run '${mvpane 8}'
            bind -n M-( run '${mvpane 9}'
            bind -n M-) run '${mvpane 10}'

            bind -n M-Q killw
            bind -n M-D detach
            bind -n M-R command-prompt -I '#W' 'rename-window "%%"'
            bind -n M-[ copy-mode
            bind -n M-] pasteb
            bind -n M-t clock-mode

            bind -n M-d run '${customSh "lsbin"} || true'
            bind -n M-b run '${customSh "bookmarks"} || true'
            bind -n M-BSpace run '${customSh "system"} > /dev/null || true'
            bind -n M-p run '${customSh "pass"} > /dev/null || true'
            bind -n M-m run '${customSh "man"} | ${pkgs.colorized-logs}/bin/ansi2txt || true'
          ''
          + builtins.concatStringsSep "\n" (
            builtins.genList (
              num:
              let
                numStr = builtins.toString (num + 1);
                lastDigit = builtins.substring (builtins.stringLength numStr - 1) 1 numStr;
              in
              "bind -n M-${lastDigit} run '${tmux} selectw -t :${numStr} || ${tmux} neww -t :${numStr}'"
            ) 10
          );
      };

      zsh.initContent = lib.mkIf config.programs.tmux.enable ''
        case $- in
        	*i*)
        		[ -z "$TMUX" ] && { ${tmux} attach || ${tmux} new }
        		;;
        esac
      '';
    };
}
