{ pkgs, colorscheme, ... }:
{
	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"$mod" = "SUPER";
			"$terminal" = "${pkgs.foot}/bin/footclient";
			"$browser" = "${pkgs.librewolf}/bin/librewolf";
			"$base00" = colorscheme.palette.base00;
			"$base01" = colorscheme.palette.base01;
			"$base02" = colorscheme.palette.base02;
			"$base03" = colorscheme.palette.base03;
			"$base04" = colorscheme.palette.base04;
			"$base05" = colorscheme.palette.base05;
			"$base06" = colorscheme.palette.base06;
			"$base07" = colorscheme.palette.base07;
			"$base08" = colorscheme.palette.base08;
			"$base09" = colorscheme.palette.base09;
			"$base0A" = colorscheme.palette.base0A;
			"$base0B" = colorscheme.palette.base0B;
			"$base0C" = colorscheme.palette.base0C;
			"$base0D" = colorscheme.palette.base0D;
			"$base0E" = colorscheme.palette.base0E;
			"$base0F" = colorscheme.palette.base0F;

			monitor = [ ",preferred,auto,1" ];

			bind = [
				"$mod, Return, exec, $terminal"
				"$mod, W, exec, $browser"
				"$mod, Q, killactive,"
				"$mod, F, togglefloating,"

				"$mod, H, movefocus, l"
				"$mod, J, movefocus, u"
				"$mod, K, movefocus, d"
				"$mod, L, movefocus, r"

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

				"$mod SHIFT, Q, exit,"
			];

			general = {
				gaps_out = 5;
				border_size = 2;
				"col.inactive_border" = "rgb($base01)";
				"col.active_border" = "rgb($base0D)";
				cursor_inactive_timeout = 5;
				layout = "master";
				no_cursor_warps = true;
			};

			decoration = {
				rounding = 2;
				blur.enabled = false;
			};

			input = {
				kb_options = "caps:escape";
				repeat_delay = 200;
				repeat_rate = 70;
			};
		};
	};
}
