{ config, pkgs, ... }:
{
  custom.programs.eww.yuck = builtins.readFile (
    pkgs.runCommand "eww.yuck" { } ''
      substitute "${./eww.yuck}" "$out" --replace-fail "jstat" "${config.custom.programs.jstat.package}/bin/jstat"
      substitute "${./eww.yuck}" "$out" --replace-fail "hyprctl" "${config.wayland.windowManager.hyprland.package}/bin/hyprctl"
    ''
  );

  systemd.user.services.eww = {
    Install.WantedBy = [ "graphical-session.target" ];

    Unit = {
      Description = "ElKowars wacky widgets daemon";
      Documentation = "https://elkowar.github.io/eww";
      PatOf = [ "graphical-session.target" ];

      After = [
        "graphical-session.target"
        "pipewire.service"
        "pipewire-pulse.service"
        "pulseaudio.service"
        "mpd.service"
      ];

      X-Restart-Triggers = [
        config.xdg.configFile."eww/eww.yuck".source
        config.xdg.configFile."eww/eww.scss".source
      ];
    };

    Service =
      let
        eww = "${config.programs.eww.package}/bin/eww";
      in
      {
        ExecStart = "${eww} daemon --no-daemonize";
        ExecStop = "${eww} kill";
        ExecReload = "${eww} reload";

        ExecStartPost = pkgs.writers.writeDash "eww" ''
          set -eu

          while ! ${pkgs.pamixer}/bin/pamixer; do
          	sleep 0.1
          done

          ${pkgs.uwsm}/bin/uwsm app -- ${pkgs.eww}/bin/eww open bar
        '';
      };
  };
}
