{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.custom.programs.eww = {
    enable = lib.mkEnableOption "eww";

    yuck = lib.mkOption {
      description = "eww.yuck";
      type = lib.types.lines;
    };

    scss = lib.mkOption {
      description = "eww.scss";
      type = lib.types.lines;
    };
  };

  config =
    let
      cfg = config.custom.programs.eww;
    in
    lib.mkIf cfg.enable {
      home.packages = [ pkgs.eww ];

      xdg.configFile = {
        "eww/eww.yuck".text = cfg.yuck;
        "eww/eww.scss".text = cfg.scss;
      };

      systemd.user.services.eww = {
        Install.WantedBy = [ "graphical-session.target" ];

        Unit = {
          Description = "ElKowars wacky widgets daemon";
          Documentation = "https://elkowar.github.io/eww";
          PartOf = [ "graphical-session.target" ];

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
            ExecStartPost = "${pkgs.uwsm}/bin/uwsm app -- ${pkgs.eww}/bin/eww open bar --screen 0";
          };
      };
    };
}
