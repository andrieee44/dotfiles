{ pkgs, ... }:
{
	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"$mod" = "SUPER";
			"$terminal" = "${pkgs.foot}/bin/footclient";
			"$browser" = "${pkgs.librewolf}/bin/librewolf";

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

			input = {
				kb_options = "caps:escape";
				repeat_delay = 200;
				repeat_rate = 70;
			};

			monitor = [
				",preferred,auto,1"
			];
		};
	};
}
