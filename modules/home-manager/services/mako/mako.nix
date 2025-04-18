{ pkgs, ... }:
{
  services.mako = {
    borderRadius = 5;
    borderSize = 5;
    defaultTimeout = 10000;
    format = "<b>%a - %s</b>\\n\\n%b";
    height = 256;
    layer = "overlay";
    margin = "20";
    maxVisible = -1;
    maxIconSize = 64;

    extraConfig = ''
      []
      on-notify=exec ${pkgs.mpv}/bin/mpv ${./notif.opus}
      text-alignment=center

      [urgency=high]
      default-timeout=0

      [urgency=low]
      on-notify=none
    '';
  };
}
