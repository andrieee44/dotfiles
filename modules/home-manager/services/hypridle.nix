{ pkgs, ... }:
{
	services.hypridle.settings = ''
		general {
			lock_cmd = ${pkgs.toybox}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock --immediate
			before_sleep_cmd = ${pkgs.systemd}/bin/loginctl lock-session
			after_sleep_cmd = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
		}

		listener {
			timeout = 30
			on-timeout = ${pkgs.light}/bin/light -O && ${pkgs.light}/bin/light -S 5
			on-resume = ${pkgs.light}/bin/light -I
		}

		listener {
			timeout = 60
			on-timeout = ${pkgs.systemd}/bin/loginctl lock-session
		}

		listener {
			timeout = 90
			on-timeout = ${pkgs.hyprland}/bin/hyprctl dispatch dpms off
			on-resume = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
		}

		listener {
			timeout = 120
			on-timeout = ${pkgs.systemd}/bin/systemctl suspend
		}
	'';
}
