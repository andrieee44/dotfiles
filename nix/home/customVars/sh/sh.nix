{ config, pkgs, options, lib, ... }:
{
	options.customVars.sh = let
		mkLinesOption = config.customVars.mkOption lib.types.lines;
	in {
		profile = mkLinesOption;
		rc = mkLinesOption;
	};

	config.customVars.sh = {
		profile = lib.mkMerge [
			(lib.optionalString config.wayland.windowManager.sway.enable ''
				pidof sway >/dev/null 2>&1 || exec ${pkgs.sway}/bin/sway
			'')
		];

		rc = lib.mkMerge [
			''
				export SSH_ASKPASS="${config.customVars.sshPassCmd}"
				export SSH_ASKPASS_REQUIRE="force"
				export PATH="$PATH:${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/mybin"
			''

			(lib.optionalString config.programs.neovim.enable ''
				export EDITOR="${config.home.homeDirectory}/.nix-profile/bin/nvim"
			'')

			(lib.optionalString (config.home.sessionVariables.PAGER == "${pkgs.moar}/bin/moar") ''
				export PAGER="${pkgs.moar}/bin/moar"
			'')

			(lib.optionalString config.programs.tmux.enable ''
				case $- in
					*i*)
						[ -z "$TMUX" ] && {
							${pkgs.tmux}/bin/tmux attach || ${pkgs.tmux}/bin/tmux new
						}
						;;
				esac
			'')
		];
	};
}
