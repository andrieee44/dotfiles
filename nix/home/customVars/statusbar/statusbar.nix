{ config, pkgs, options, ... }:
{
	options.customVars.statusbar = let
		mkPkgOption = config.customVars.mkPkgOption;
	in
	{
		volume = mkPkgOption "volume";
		battery = mkPkgOption "battery";
		brightness = mkPkgOption "brightness";
		cpu = mkPkgOption "cpu";
		date = mkPkgOption "date";
		ram = mkPkgOption "ram";
	};

	config.customVars.statusbar = let
		shell = ''#!${pkgs.dash}/bin/dash
			set -eu
		'';
		unixUtils = config.customVars.unixUtils;
	in {
		volume = pkgs.writeScriptBin "volume" ''${shell}
			icon="VOL:"

			volume="$(${pkgs.pamixer}/bin/pamixer --get-volume 2>/dev/null)"

			[ "$(${pkgs.pamixer}/bin/pamixer --get-mute)" = "true" ] &&
				echo "${"\${icon}"} muted" ||
				echo "${"\${icon} \${volume}"}%"
		'';

		battery = pkgs.writeScriptBin "battery" ''${shell}
			name="BAT0"
			stat="$(${unixUtils}/cat /sys/class/power_supply/${"\${name}"}/status)"
			percent="$(${unixUtils}/cat /sys/class/power_supply/${"\${name}"}/capacity)"

			${unixUtils}/awk -v "icon=BAT:" -v "stat=${"\${stat}"}" -v "percent=${"\${percent}"}" '
				BEGIN {
					map["Charging"] = "+"
					map["Discharging"] = "-"
					map["Full"] = "o"
					map["Not charging"] = "!"
					map["Unknown"] = "?"

					print(icon, map[stat] percent "%")
				}
			'
		'';

		brightness = pkgs.writeScriptBin "brightness" ''${shell}
			brightness="$(${pkgs.light}/bin/light)"

			${unixUtils}/awk -v "icon=BRI:" -v "brightness=${"\${brightness}"}" '
				BEGIN {
					print(icon, int(brightness + 0.5) "%")
				}
			'
		'';

		cpu = pkgs.writeScriptBin "cpu" ''${shell}
			${unixUtils}/top -bn1 | ${unixUtils}/awk -v "icon=CPU:" '
				/^CPU:/ {
					print(icon, 100 - $8 "%")
				}
			'
		'';

		date = pkgs.writeScriptBin "date" ''${shell}
			${unixUtils}/date "+%b %d %Y (%a) %I:%M %p"
		'';

		ram = pkgs.writeScriptBin "ram" ''${shell}
			${unixUtils}/free | awk -v "icon=RAM:" '
				/^Mem:/ {
					print(icon, $3 / $2 * 100.0)
				}
			'
		'';
	};
}
