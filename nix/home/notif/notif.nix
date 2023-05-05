{ config, pkgs, lib, options, ... }:
let
	mkPkgOption = name: lib.mkOption {
		type = lib.types.package;
		description = "Package value for ${name}.";
	};
in
{
	options.customVars.notifs = {
		music = mkPkgOption "music";
		brightness = mkPkgOption "brightness";
		volume = mkPkgOption "volume";
	};

	config.customVars.notifs = {
		music = pkgs.writeScriptBin "music" ''#!${pkgs.dash}/bin/dash
			set -eu
			tmp="$(${pkgs.coreutils}/bin/mktemp -p "/tmp" --suffix ".jpg" "music.XXXXXXXXXX")"
			trap '${pkgs.busybox}/bin/rm -f "$tmp"' INT HUP QUIT TERM PWR EXIT
			info="$(${pkgs.mpc-cli}/bin/mpc -f '%file%\n[%title%\n%album%\n%artist%]|[%file%\n\n]')"
			[ "$(echo "$info" | ${pkgs.busybox}/bin/wc -l)" -eq 1 ] && exit 1
			${pkgs.ffmpeg}/bin/ffmpeg -y -i "${config.services.mpd.musicDirectory}/$(echo "$info" | ${pkgs.busybox}/bin/head -n 1)" "$tmp"

			${pkgs.libnotify}/bin/notify-send -c "x-notifications.music" -h "int:value:$(echo "$info" | ${pkgs.busybox}/bin/sed -n '''"$(($(echo "$info" | ${pkgs.busybox}/bin/wc -l) - 1))"' s/.*(\([0-9]\{1,3\}\)%).*/\1/p')" \
				-i "$tmp" \
				"$(echo "$info" | ${pkgs.busybox}/bin/sed -n '2 p')" \
				"$(echo "$info" | ${pkgs.busybox}/bin/sed -n '3,4 p')\n$(echo "$info" | ${pkgs.busybox}/bin/awk 'FNR == 5 { print $3 }')"
		'';

		brightness = pkgs.writeScriptBin "brightness" ''#!${pkgs.dash}/bin/dash
			set -eu
			perc="$(${pkgs.light}/bin/light)"
			icons="\
				90 
				75 
				60 
				45 
				30 
				15 
				0 "

			icon="$(echo "$icons" | ${pkgs.busybox}/bin/awk '
			{
				if ('"$perc"' >= $1) {
					print $2
					exit
				}
			}'
			)"

			${pkgs.libnotify}/bin/notify-send -c "x-notifications.brightness" -h "int:value:${"\${perc}"}" "${"\${icon}"} Brightness ${"\${icon}"}"
		'';

		volume = pkgs.writeScriptBin "volume" ''#!${pkgs.dash}/bin/dash
			info="$(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_SINK@)"
			perc="$(echo "$info" | awk '{ print $2 * 100 }')"
			muted="$(echo "$info" | awk '{ print $3 }')"
			icons="\
				66 
				33 
				0 "

			icon="$(echo "$icons" | ${pkgs.busybox}/bin/awk '
			{
				if ('"$perc"' >= $1) {
					print $2
					exit
				}
			}'
			)"

			${pkgs.libnotify}/bin/notify-send -c "x-notifications.volume" -h "int:value:${"\${perc}"}" "${"\${icon}"} Volume ${"\${icon}"}" "${"$muted"}"
		'';
	};
}
