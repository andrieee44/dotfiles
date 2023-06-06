{ config, pkgs, options, lib, ... }:
{
	options.customVars.sh = let
		mkLinesOption = config.customVars.mkLinesOption;
	in
	{
		profile = mkLinesOption "profile";
		rc = mkLinesOption "rc";
	};


	config.customVars.sh = {
		profile = lib.mkMerge [
			(lib.mkIf config.wayland.windowManager.sway.enable ''
				pidof sway >/dev/null 2>&1 || exec ${pkgs.sway}/bin/sway
			'')
		];

		rc = lib.mkMerge [
			''
				export SSH_ASKPASS="${config.customVars.sshPassCmd}"
				export SSH_ASKPASS_REQUIRE="force"
				export PATH="$PATH:${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.local/mybin"
			''

			(lib.mkIf config.programs.neovim.enable ''
				export EDITOR="${config.home.homeDirectory}/.nix-profile/bin/nvim"
			'')

			(lib.mkIf config.programs.tmux.enable ''
				case $- in
					*i*)
						[ -z "$TMUX" ] && {
							${pkgs.tmux}/bin/tmux attach || ${pkgs.tmux}/bin/tmux new
						}
						;;
				esac
			'')

			''
				eval "$(${pkgs.coreutils}/bin/dircolors -b "${config.home.homeDirectory}/${config.home.file.dircolors.target}")"
			''
		];
	};
}
