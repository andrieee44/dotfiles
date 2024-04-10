{ pkgs, ... }:
{
	wayland.windowManager.hyprland = {
		enable = true;

		settings = {
			"$terminal" = "${pkgs.foot}/bin/foot";
			"$mod" = "SUPER";

			bind = [
				"$mod, Return, exec, $terminal"
			];

			input = {
				kb_options = "caps:escape";
				repeat_delay = 200;
				repeat_rate = 70;
			};
		};
	};
}
