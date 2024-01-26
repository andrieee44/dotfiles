{ config, pkgs, lib, options, ... }:
{
	options.customVars.notifs = let
		mkPkgOption = config.customVars.mkOption lib.types.package;
	in
	{
		music = mkPkgOption;
		musicLoop = mkPkgOption;
		brightness = mkPkgOption;
		volume = mkPkgOption;
	};

	config.customVars.notifs = {
		music = pkgs.writeScriptBin "music" ''#!${pkgs.dash}/bin/dash
			set -eu

			mpcInfo="$(${pkgs.mpc-cli}/bin/mpc -f '%file%[\n%title%\n][%album%\n][%artist%]')"
			[ "$(echo "$mpcInfo" | ${pkgs.busybox}/bin/wc -l)" -eq 1 ] && {
				${pkgs.libnotify}/bin/notify-send -c "x-notifications.music" "Now stopped:" "Queue some music!"
				exit
			}

			cover=""
			trap '${pkgs.busybox}/bin/rm -f "$cover"' INT HUP QUIT TERM PWR EXIT
			cover="$(${pkgs.coreutils}/bin/mktemp -p "/tmp" --suffix ".jpg" "music.XXXXXXXXXX")"

			${pkgs.ffmpeg}/bin/ffmpeg -v warning -y -vsync vfr -i "${config.services.mpd.musicDirectory}/$(echo "$mpcInfo" | ${pkgs.busybox}/bin/head -n 1)" "$cover" || true

			statusLine="$(($(echo "$mpcInfo" | ${pkgs.busybox}/bin/wc -l) - 1))"
			${pkgs.libnotify}/bin/notify-send -c "x-notifications.music" -h "int:value:$(echo "$mpcInfo" | ${pkgs.busybox}/bin/sed -n "
				${"\${statusLine}"}"' {
						s/.*(\([0-9]\{1,3\}\)%).*/\1/p
						q
					}
				')" \
				-i "$cover" \
				"Now $(echo "$mpcInfo" | ${pkgs.busybox}/bin/sed -n "
					${"\${statusLine}"}"' {
						s/.*\[\(.\+\)\].*/\1/p
						q
					}
				'):" \
				"$(echo "$mpcInfo" | ${pkgs.busybox}/bin/awk -v statusLine="$statusLine" '
					{
						if (NR == statusLine) {
							print $3
							exit
						}

						if (statusLine == 2) {
							print "<u><b>"$0"</b></u>"
							next
						}

						if (NR == 1) {
							next
						}

						if (NR == 2) {
							print "<u><b>"$0"</b>"
						}

						if (NR == 3) {
							print $0"</u>"
						}

						if (NR == 4) {
							print "<i>"$0"</i>"
						}
					}'
				)"
		'';

		brightness = pkgs.writeScriptBin "brightness" ''#!${pkgs.dash}/bin/dash
			set -eu
			perc="$(${pkgs.light}/bin/light)"
			icons='
				90 ; 
				75 ; 
				60 ; 
				45 ; 
				30 ; 
				15 ; 
				0 ; 
			'

			icon="$(echo "$icons" | ${pkgs.busybox}/bin/awk -v perc="$perc" '
				BEGIN {
					FS = ";"
				}
				{
					if (NF && perc >= $1) {
						gsub("[[:space:]]*", "", $2)
						print $2
						exit
					}
				}'
			)"

			${pkgs.libnotify}/bin/notify-send -c "x-notifications.brightness" -h "int:value:${"\${perc}"}" "${"\${icon}"} Brightness ${"\${icon}"}"
		'';

		volume = pkgs.writeScriptBin "volume" ''#!${pkgs.dash}/bin/dash
			set -eu
			info="$(${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_SINK@)"

			perc="$(echo "$info" | ${pkgs.busybox}/bin/awk '
				{
					print $2 * 100
				}
			')"

			muted="$(echo "$info" | ${pkgs.busybox}/bin/awk '
				{
					print $3
				}
			')"

			icons='
				66 ; 
				33 ; 
				0 ; 
			'

			icon="$(echo "$icons" | ${pkgs.busybox}/bin/awk -v perc="$perc" '
				BEGIN {
					FS = ";"
				}
				{
					if (NF && perc >= $1) {
						gsub("[[:space:]]*", "", $2)
						print $2
						exit
					}
				}'
			)"

			${pkgs.libnotify}/bin/notify-send -c "x-notifications.volume" -h "int:value:${"\${perc}"}" "${"\${icon}"} Volume ${"\${icon}"}" "$muted"
		'';

		musicLoop = pkgs.writeScriptBin "musicLoop" ''#!${pkgs.dash}/bin/dash
			mpc idleloop player | while read -r _ ; do
				${config.customVars.notifs.music}/bin/music
			done
		'';
	};
}
