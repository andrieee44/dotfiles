{ config, pkgs, options, lib, ... }:
{
	options.customVars.fzfscripts = let
		mkPkgOption = config.customVars.mkPkgOption;
	in {
		pathmenu = mkPkgOption "pathmenu";
		sysmenu = mkPkgOption "sysmenu";
		preview = mkPkgOption "preview";
	};

	config.customVars.fzfscripts = let
		fzf-tmuxArgs = ''
			-p "45%,60%" $(set +u && [ -n "$TMUX" ] && echo "--border=sharp")
		'';

		shShebang = config.customVars.shShebang;
		unixUtils = config.customVars.unixUtils;
	in {
		pathmenu = pkgs.writeScriptBin "pathmenu" ''${shShebang}
			bin=""
			IFS=:
			for d in $PATH; do
				[ ! -d "$d" ] && continue
				bin="${"\${bin}"}$(${unixUtils}/find -L "$d" -mindepth 1 -maxdepth 1 -type f -perm -u=x -not -name '.*')"
			done

			cmd="$(echo "$bin" | ${unixUtils}/sed 's/.*\///' | ${unixUtils}/sort | ${pkgs.fzf}/bin/fzf-tmux --header "Search executable:" ${fzf-tmuxArgs})"

			[ ! -t 1 ] && echo "$cmd" && exit
			eval "$cmd"
		'';

		sysmenu = pkgs.writeScriptBin "sysmenu" ''${shShebang}
			arr='
				lock wayland session ; ${pkgs.systemd}/bin/loginctl lock-session
				leave wayland session ; ${pkgs.systemd}/bin/loginctl kill-session self
				reload window manager ; ${lib.optionalString config.wayland.windowManager.sway.enable "${pkgs.sway}/bin/swaymsg reload"}
				poweroff computer ; ${pkgs.systemd}/bin/poweroff
				reboot computer ; ${pkgs.systemd}/bin/reboot
			'

			cmd="$(echo "$arr" | ${unixUtils}/sed -n '
				s/^[[:space:]]*\(.\+\)[[:space:]]*;.*$/\1/p
			' | ${pkgs.fzf}/bin/fzf-tmux --header "System action:" ${fzf-tmuxArgs})"

			err="$?"
			[ "$err" -ne 0 ] && exit "$err"

			eval "$(echo "$arr" | ${unixUtils}/sed -n '
				/'"${"\${cmd}"}"'/ {
					s/^[[:space:]]*'"${"\${cmd}"}"'[[:space:]]*;[[:space:]]*\(.\+\)[[:space:]]*$/\1/p
					q
				}
			')"
		'';

		preview = pkgs.writeScriptBin "preview" ''${shShebang}
			file="$1"

			case "$(${pkgs.file}/bin/file --dereference --brief --mime-type -- "$file")" in
				text/html)
					${pkgs.w3m}/bin/w3m -T text/html <"$file"
					;;
				text/* | */xml | application/json)
					${lib.optionalString config.programs.neovim.enable ''
						${pkgs.moar}/bin/moar "$file"
					''}
					;;
				application/pgp-encrypted)
					${pkgs.gnupg}/bin/gpg2 -d -- "$file" ;;
			esac
		'';
	};
}
