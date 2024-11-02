{ config, lib, ... }:
{
  options.stylix.targets.custom.tmux.enable = lib.mkEnableOption "custom implementation of styling tmux";

  config.programs.tmux.extraConfig =
    let
      colors = config.lib.stylix.colors.withHashtag;
      guiBool = "#{!=:${"\${XDG_SESSION_TYPE}"},tty}";
      gui = t: f: "#{?${guiBool},${t},${f}}";
      bell = t: f: "#{?window_bell_flag,${t},${f}}";
    in
    lib.mkIf config.stylix.targets.custom.tmux.enable ''
      set -g status-style "fg=${gui "#${colors.base05}" "white"},bg=${gui "#${colors.base00}" "black"}"
      set -g window-status-bell-style "fg=${gui "#${colors.base00}" "black"},bg=${gui "#${colors.base08}" "red"}"
      set -g pane-border-style "fg=${gui "#${colors.base03}" "brightblack"}"
      set -g pane-active-border-style "fg=${gui "#${colors.base0D}" "blue"}"
      set -g mode-style "fg=${gui "#${colors.base00}" "black"},bg=${gui "#${colors.base05}" "white"}"
      set -g message-style "fg=${gui "#${colors.base05}" "white"},bg=${gui "#${colors.base00}" "black"}"
      set -g message-command-style "fg=${gui "#${colors.base05}" "white"},bg=${gui "#${colors.base03}" "brightblack"}"
      set -Fg clock-mode-colour "${gui "#${colors.base0D}" "blue"}"
      set -g status-left "#[fg=${gui "#${colors.base00}" "black"},bg=${gui "#${colors.base0D}#,bold" "blue#,bold"}] #S #[fg=${gui "#${colors.base0D}" "blue"},bg=${gui "#${colors.base00}" "black"}]${gui "" " "}"
      set -g status-right "#[fg=${gui "#${colors.base03}" "brightblack"},bg=${gui "#${colors.base00}" "black"}]${gui "" ""}#[fg=${gui "#${colors.base05}" "white"},bg=${gui "#${colors.base03}" "brightblack"}] ${gui "󰥔 " ""}%b %e %Y (%a) %l:%M %p #[fg=${gui "#${colors.base0D}" "blue"},bg=${gui "#${colors.base03}" "brightblack"}]${gui "" ""}#[fg=${gui "#${colors.base00}" "black"},bg=${gui "#${colors.base0D}#,bold" "blue#,bold"}] ${gui " " ""}#{user}@#H "
      set -g window-status-current-format "#[fg=${gui "#${colors.base00}" "black"},bg=${gui "#${colors.base0D}" "blue"}]${gui "" ""}#[fg=${gui "#${colors.base00}" "black"},bg=${gui "#${colors.base0D}#,bold" "blue#,bold"}] #I ${gui "" "|"} #W #[fg=${gui "#${colors.base0D}" "blue"},bg=${gui "#${colors.base00}" "black"}]${gui "" " "}"
      set -g window-status-format "#[fg=${gui "#${colors.base00}" "black"},bg=${bell "${gui "#${colors.base08}" "red"}" "${gui "#${colors.base03}" "brightblack"}"}]${gui "" ""}#[fg=${bell "${gui "#${colors.base00}" "black"}" "${gui "#${colors.base05}" "white"}"},bg=${bell "${gui "#${colors.base08}#,bold" "red#,bold"}" "${gui "#${colors.base03}#,nobold" "brightblack#,nobold"}"}] #I ${gui "" "|"} #W #[fg=${bell "${gui "#${colors.base08}" "red"}" "${gui "#${colors.base03}" "brightblack"}"},bg=${gui "#${colors.base00}" "black"}]${gui "" " "}"
    '';
}
