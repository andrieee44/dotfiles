{ pkgs, ... }:
{
  services.mako.settings = {
    border-radius = 5;
    border-size = 5;
    default-timeout = 10000;
    format = "<b>%a - %s</b>\\n\\n%b";
    height = 256;
    layer = "overlay";
    margin = "20";
    max-icon-size = 64;
    max-visible = -1;
    on-notify = "exec ${pkgs.mpv}/bin/mpv ${./notif.opus}";
    text-alignment = "center";
    "urgency=high".default-timeout = 0;
    "urgency=low".on-notify = "none";
  };
}
