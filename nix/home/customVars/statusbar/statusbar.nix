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
		shShebang = config.customVars.shShebang;
		unixUtils = config.customVars.unixUtils;
	in {
		volume = pkgs.writeScriptBin "volume" ''${shShebang}
			icon="VOL:"

			volume="$(${pkgs.pamixer}/bin/pamixer --get-volume 2>/dev/null)"

			[ "$(${pkgs.pamixer}/bin/pamixer --get-mute)" = "true" ] &&
				echo "${"\${icon}"} muted" ||
				echo "${"\${icon} \${volume}"}%"
		'';

		battery = pkgs.writeScriptBin "battery" ''${shShebang}
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

		brightness = pkgs.writeScriptBin "brightness" ''${shShebang}
			brightness="$(${pkgs.light}/bin/light)"

			${unixUtils}/awk -v "icon=BRI:" -v "brightness=${"\${brightness}"}" '
				BEGIN {
					print(icon, int(brightness + 0.5) "%")
				}
			'
		'';

		cpu = pkgs.writeScriptBin "cpu" ''${shShebang}
			${unixUtils}/top -bn1 | ${unixUtils}/awk -v "icon=CPU:" '
				/^CPU:/ {
					print(icon, 100 - $8 "%")
				}
			'
		'';

		date = pkgs.writeScriptBin "date" ''${shShebang}
			${unixUtils}/date "+${config.customVars.dateFmt}"
		'';

		ram = pkgs.writeScriptBin "ram" ''${shShebang}
			${unixUtils}/free | awk -v "icon=RAM:" '
				/^Mem:/ {
					print(icon, $3 / $2 * 100.0)
				}
			'
		'';
	};
}
