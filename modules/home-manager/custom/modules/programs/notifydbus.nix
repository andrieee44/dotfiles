{ config, lib, ... }:
{
  options.custom.programs.notifydbus = {
    enable = lib.mkEnableOption "notifydbus";
    package = lib.mkOption { type = lib.types.package; };
  };

  config =
    let
      cfg = config.custom.programs.notifydbus;
    in
    {
      home.packages = lib.mkIf cfg.enable [ cfg.package ];

      systemd.user.services.notifydbus = {
        Install.WantedBy = [ "graphical-session.target" ];
        Service.ExecStart = "${cfg.package}/bin/notifydbus";

        Unit = {
          Description = "notifydbus - message bus notification sender daemon";
          Documentation = "github.com/andrieee44/notifydbus";
          PartOf = [ "graphical-session.target" ];

          After = [
            "graphical-session.target"
            "pipewire.service"
            "pipewire-pulse.service"
            "pulseaudio.service"
            "mpd.service"
          ];
        };
      };
    };
}
