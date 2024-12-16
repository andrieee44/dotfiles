{ config, pkgs, ... }:
{
  custom.programs.eww.yuck = builtins.readFile (
    pkgs.runCommand "eww.yuck" { } ''
        substitute "${./eww.yuck}" "$out" \
      		--replace "lock.yuck" "${./lock.yuck}" \
      		--replace "jstat" "${config.custom.programs.jstat.package}/bin/jstat" \
      		--replace "hyprctl" "${config.wayland.windowManager.hyprland.package}/bin/hyprctl"
    ''
  );
}
