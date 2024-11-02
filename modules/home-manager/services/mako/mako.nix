{ pkgs, ... }:
{
  services.mako = {
    borderRadius = 5;
    borderSize = 5;
    defaultTimeout = 10000;
    format = "<b>%a - %s</b>\\n\\n%b";
    height = 150;
    layer = "overlay";
    margin = "20,20";

    extraConfig = ''
      []
      on-notify=exec ${pkgs.mpv}/bin/mpv ${./notif.ogg}
      text-alignment=center

      [urgency=high]
      default-timeout=0'';
  };
}
