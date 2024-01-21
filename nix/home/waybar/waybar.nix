{ config, options, lib, pkgs, ... }:
let
	customVars = config.customVars;
in {
	options.customVars.waybar = {
		separatorColor = customVars.mkStrOption;
		color = customVars.mkStrOption;
	};

	config.programs.waybar = let
		sway = config.wayland.windowManager.sway.enable;
		swayStr = lib.optionalString sway;
	in {
		settings.mainBar = let
			shShebang = customVars.shShebang;
			unixUtils = customVars.unixUtils;
			nerdFontBool = customVars.fonts.nerdFontBool;
			waybar = customVars.waybar;

			icon = nerd: fallback:
			"<span color='${waybar.color}'>${if nerdFontBool then
				nerd else fallback
			}</span>";

			separator = str:
			" <span color='${waybar.separatorColor}'>|</span> ${str}";

			separatorIcon = nerd: fallback:
			separator (icon nerd fallback);

			iconList = list: fallback:
			lib.forEach list (nerd:
			icon nerd fallback);

			separatorIconList = list: fallback:
			lib.forEach list (nerd:
			separatorIcon nerd fallback);
		in {
        	network = {
				tooltip = false;
				format = "{essid}";
				format-wifi = "{icon} {essid}";
				format-ethernet = "${icon "󰈀" "Eth:"} {essid}";
				format-disconnected = "${icon "󰤭" "Wifi:"} Offline";
				format-icons = iconList [
					"󰤯" "󰤟" "󰤢" "󰤥" "󰤨"
				] "Wifi:";
			};

			wireplumber = {
				format-muted = "${separatorIcon "󰝟" "Vol:"} Muted";
				format-icons = separatorIconList [
					"" "" ""
				] "Vol:";
			};

			layer = "bottom";
			position = "top";
			height = 46;
			margin-top = 10;
			margin-left = 10;
			margin-right = 10;

			output = [
				"*"
			];

			modules-left = [
				(swayStr "sway/workspaces")
				(swayStr "sway/mode")
				"custom/separator"
				(swayStr "sway/window")
			];

			modules-center = [
			];

			modules-right = [
				"network"
				"bluetooth"
				"cpu"
				"memory"
				"backlight"
				"wireplumber"
				"battery"
				"custom/uptime"
				"custom/user"
				"custom/clock"
			];

			backlight = {
				tooltip = false;
				format = "{icon} {percent}%";
				format-icons = separatorIconList [
					"󰃞" "󰃟" "󰃝" "󰃠"
				] "Bri:";
			};

			battery = {
				tooltip = false;
				design-capacity = false;
				format = "{icon} {time} -{capacity}%";
				format_time = "{H}:{m}";
				format-plugged = "{icon} +{capacity}%";
				format-icons = separatorIconList [
					"" "" "" "" ""
				] "Bat:";
			};

			bluetooth = {
				tooltip = false;
				format = "${separatorIcon "" "Blue:"} {status}";
				format-connected = "${separatorIcon "" "Blue:"} {device_alias}";
				format-connected-battery = "${separatorIcon "" "Blue:"} {device_alias} {device_battery_percentage}%";
				format-disabled = "";
			};

			"custom/clock" = {
				tooltip = false;
				interval = 60;
				format = "${separatorIcon "󰃰" "Date:"} {} ";
				exec = pkgs.writeScript "date" ''${shShebang}
					${unixUtils}/date "+${config.customVars.dateFmt}"
				'';
			};

			"custom/separator" = {
				tooltip = false;
				interval = "once";
				format = "<span color='${waybar.separatorColor}'>|</span> ";
			};

			"custom/uptime" = {
				tooltip = false;
				interval = 60;
				format = "${separatorIcon "󰭖" "Up:"} {} up";
				exec = pkgs.writeScript "uptime" ''${shShebang}
					${pkgs.coreutils}/bin/uptime | ${pkgs.gawk}/bin/gawk '1 {
						gsub(",", "", $3)
						print $3
					}'
				'';
			};

			"custom/user" = {
				tooltip = false;
				interval = 60;
				format = "${separatorIcon "" "User:"} {}";
				exec = pkgs.writeScript "user" ''${shShebang}
					${unixUtils}/whoami
				'';
			};

			cpu = {
				tooltip = false;
				interval = 5;
				format = "${separatorIcon "" "Cpu:"} {usage}%";
			};

			memory = {
				tooltip = false;
				interval = 5;
				format = "${separatorIcon "󰓌" "Ram:"} {percentage}%";
			};

			"sway/mode" = lib.mkIf sway {
				tooltip = false;
				format = "<span color='${waybar.separatorColor}'>|</span> ${icon "󰂮" "Mode:"} {} ";
			};

			"sway/window" = lib.mkIf sway {
				tooltip = false;
				format = "{title}";
				max-length = 40;
				all-outputs = false;
				icon = true;
				icon-size = 20;
			};

			"sway/workspaces" = lib.mkIf sway {
				tooltip = false;
				format = "{name}";
				all-outputs = false;
				disable-scroll = true;
				disable-click = true;
				disable-scroll-wraparound = true;
				enable-bar-scroll = false;
				warp-on-scroll = false;
			};

			user = {
				tooltip = false;
				interval = 60;
				open-on-click = false;
			};

			wireplumber = {
				tooltip = false;
				format = "{icon} {volume}%";
			};
		};

		style = ''
			* {
				border-radius: 0;
				font-size: ${builtins.toString config.gtk.font.size}pt;
			}

			#workspaces button {
				padding-left: 10px;
				padding-right: 10px;
			}
		'';

		systemd = {
			enable = true;
			target = "sway-session.target";
		};
	};
}
