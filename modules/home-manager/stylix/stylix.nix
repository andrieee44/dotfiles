{ config, ... }:
{
	stylix.targets = {
		firefox.profileNames = [ "default" ];
		fzf.enable = false;
		tmux.enable = false;

		custom = {
			aerc.enable = true;
			fzf.enable = true;
			hyprland.enable = true;
			hyprlock.enable = true;
			imv.enable = true;
			mpv.enable = true;
			ncmpcpp.enable = true;
			tmux.enable = true;
			zsh.enable = true;

			eww = {
				enable = true;

				border = {
					radius = config.wayland.windowManager.hyprland.settings.decoration.rounding;
					width = config.wayland.windowManager.hyprland.settings.general.border_size;
					color = config.lib.stylix.colors.withHashtag.base0D;
				};
			};

			nixvim = {
				enable = true;

				transparent_bg = {
					lineNumbers = true;
					otherWindows = true;
				};
			};

			mangohud = {
				enable = true;
				background_alpha = 0.5;
			};
		};

		nixvim.transparent_bg = {
			main = true;
			sign_column = true;
		};
	};
}
