{ config, pkgs, lib, ... }:
{
	wayland.windowManager.hyprland.settings = {
		"$mod" = "SUPER";
		"$terminal" = "${pkgs.foot}/bin/footclient";
		"$browser" = "firefox-esr";

		monitor = [ ",preferred,auto,1" ];
		exec-once = [ "${pkgs.hypridle}/bin/hypridle" ];
		master.mfact = 0.5;
		debug.disable_logs = false;

		bind = [
			"$mod, Return, execr, $terminal"
			"$mod, W, execr, $browser"

			"$mod, Q, killactive,"
			"$mod SHIFT, Q, exit,"

			"$mod, F, fullscreen,"
			"$mod, Space, layoutmsg, swapwithmaster"

			"$mod, 1, workspace, 1"
			"$mod, 2, workspace, 2"
			"$mod, 3, workspace, 3"
			"$mod, 4, workspace, 4"
			"$mod, 5, workspace, 5"
			"$mod, 6, workspace, 6"
			"$mod, 7, workspace, 7"
			"$mod, 8, workspace, 8"
			"$mod, 9, workspace, 9"
			"$mod, 0, workspace, 10"

			"$mod SHIFT, 1, movetoworkspace, 1"
			"$mod SHIFT, 2, movetoworkspace, 2"
			"$mod SHIFT, 3, movetoworkspace, 3"
			"$mod SHIFT, 4, movetoworkspace, 4"
			"$mod SHIFT, 5, movetoworkspace, 5"
			"$mod SHIFT, 6, movetoworkspace, 6"
			"$mod SHIFT, 7, movetoworkspace, 7"
			"$mod SHIFT, 8, movetoworkspace, 8"
			"$mod SHIFT, 9, movetoworkspace, 9"
			"$mod SHIFT, 0, movetoworkspace, 10"

			", Print, execr, ${pkgs.grimblast}/bin/grimblast copy"
			"SHIFT, Print, execr, ${pkgs.grimblast}/bin/grimblast copy area"
		];

		binde = [
			"$mod, J, cyclenext,"
			"$mod, K, cyclenext, prev"

			"$mod, H, splitratio, -0.02"
			"$mod, L, splitratio, +0.02"
		];

		bindl = [
			", XF86AudioMute, execr, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

			", XF86AudioPrev, execr, ${pkgs.mpc-cli}/bin/mpc prev"
			", XF86AudioNext, execr, ${pkgs.mpc-cli}/bin/mpc next"
			", XF86AudioStop, execr, ${pkgs.mpc-cli}/bin/mpc stop"
			", XF86AudioPlay, execr, ${pkgs.mpc-cli}/bin/mpc toggle"
		];

		bindel = [
			", XF86AudioRaiseVolume, execr, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
			", XF86AudioLowerVolume, execr, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
		];

		general = {
			gaps_out = 20;
			border_size = 5;
			layout = "master";
		};

		decoration = {
			rounding = 5;
			blur.size = 2;
		};

		input = {
			kb_options = "caps:escape";
			repeat_delay = 200;
			repeat_rate = 70;
		};

		misc = {
			disable_hyprland_logo = true;
			disable_splash_rendering = true;
			splash_font_family = config.gtk.font.name;
			mouse_move_enables_dpms = true;
			key_press_enables_dpms = true;
			animate_manual_resizes = true;
		};
	};

	programs.zsh.profileExtra = lib.mkIf config.wayland.windowManager.hyprland.enable ''
		[ "$SHLVL" -eq 1 ] && {
			${pkgs.systemd}/bin/systemctl --user status hyprland-session.target > /dev/null 2>& 1 && export XDG_SESSION_TYPE="tty" || exec ${pkgs.hyprland}/bin/Hyprland
		}
	'';
}
