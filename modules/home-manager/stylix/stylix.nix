{ ... }:
{
	stylix.targets = {
		firefox.profileNames = [ "default" ];
		tmux.enable = false;
		fzf.enable = false;

		custom = {
			aerc.enable = true;
			imv.enable = true;
			mpv.enable = true;
			zsh.enable = true;
			tmux.enable = true;
			fzf.enable = true;

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
