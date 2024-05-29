{
	stylix.targets = {
		firefox.profileNames = [ "default" ];
		fzf.enable = false;
		tmux.enable = false;

		custom = {
			aerc.enable = true;
			fzf.enable = true;
			hyprlock.enable = true;
			imv.enable = true;
			mpv.enable = true;
			tmux.enable = true;
			zsh.enable = true;

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
