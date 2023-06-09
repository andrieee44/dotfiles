{ config, pkgs, lib, ... }:
{
	config.programs.zsh = {
		enableAutosuggestions = true;
		enableCompletion = true;
		enableSyntaxHighlighting = true;
		autocd = false;
		dotDir = lib.removePrefix "${config.home.homeDirectory}/" "${config.xdg.configHome}/zsh";
		defaultKeymap = "viins";

		history = {
			expireDuplicatesFirst = true;
			ignoreDups = true;
			path = "${config.xdg.dataHome}/zsh/history";
			save = 100000;
			size = 100000;
			share = true;
		};

		initExtra = let
			colorschemes = {
				nord = "%B%{$fg[white]%}[%{$fg[cyan]%}%n@%M %{$fg[blue]%}%~%{$fg[yellow]%}%(?.. %?)%{$fg[white]%}]$%b%{$reset_color%} ";
			};
		in lib.mkMerge [
			''
				setopt INC_APPEND_HISTORY

				autoload -U colors && colors
				PS1="${colorschemes.${config.customVars.colorscheme}}"

				zstyle ':completion:*' menu select
				_comp_options+=(globdots)
				zmodload zsh/complist
			''

			(lib.optionalString (config.programs.zsh.defaultKeymap == "viins") ''
				export KEYTIMEOUT=1

				bindkey -M menuselect 'h' vi-backward-char
				bindkey -M menuselect 'k' vi-up-line-or-history
				bindkey -M menuselect 'l' vi-forward-char
				bindkey -M menuselect 'j' vi-down-line-or-history
				bindkey -v '^?' backward-delete-char

				zle-keymap-select () {
					case "$KEYMAP" in
						vicmd)
							echo -ne '\e[1 q'
							;;
						viins|main)
							echo -ne '\e[5 q'
							;;
					esac
				}

				zle-line-init() {
					zle -K viins
					echo -ne '\e[5 q'
				}

				preexec() {
					echo -ne '\e[5 q'
				}

				zle -N zle-keymap-select
				zle -N zle-line-init
				echo -ne '\e[5 q'
			'')

			(lib.optionalString config.programs.zsh.enableAutosuggestions ''
				ZSH_AUTOSUGGEST_MANUAL_REBIND="1"
				ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=12'
			'')

			config.customVars.sh.rc
		];

		envExtra = lib.mkMerge [
			config.customVars.sh.profile
		];
	};
}
