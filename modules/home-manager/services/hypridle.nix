{ pkgs, ... }:
{
	services.hypridle.settings = ''
		general {
			lock_cmd = ${pkgs.toybox}/bin/pidof Hyprland || ${pkgs.hyprlock}/bin/hyprlock
			unlock_cmd = ${pkgs.hyprlock}/bin/hyprlock
			before_sleep_cmd = ${pkgs.systemd}/bin/loginctl lock-session
			after_sleep_cmd = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
		}

		listener {
			timeout = 300
			on-timeout = ${pkgs.systemd}/bin/loginctl lock-session
		}

		listener {
			timeout = 360
			on-timeout = ${pkgs.hyprland}/bin/hyprctl dispatch dpms off
			on-resume = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
		}

		listener {
			timeout = 420
			on-timeout = ${pkgs.systemd}/bin/systemctl suspend
		}
	'';
}
