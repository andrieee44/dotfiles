{
  config,
  pkgs,
  lib,
  ...
}:
{
  systemd.user = lib.mkIf config.services.mbsync.enable {
    timers.mbsync.Unit.After = [ "network-online.target" ];
    services.mbsync.Service.ExecStart = lib.mkForce "-${config.programs.mbsync.package}/bin/mbsync --all --verbose";
  };

  services.mbsync = {
    frequency = "*:0/15";

    postExec = "-${pkgs.writers.writeDash "postdelivery" ''
      set -eu

      ${pkgs.mu}/bin/mu index
      unread="$(${pkgs.mu}/bin/mu find 'flag:unread' | ${pkgs.toybox}/bin/wc -l)"
      ${pkgs.notmuch}/bin/notmuch new
      [ "$unread" -ne 0 ] && ${pkgs.notify-desktop}/bin/notify-desktop -a "mbsync"  "You have ${"\${unread}"} unread emails"
    ''}";
  };
}
