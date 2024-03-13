{ config, lib, pkgs, colorscheme, ... }:
{
	programs.waybar = {
		settings.mainBar = let
			sway = config.wayland.windowManager.sway.enable;
			swayStr = lib.optionalString sway;
			color = colorscheme.palette.base0C;
			separatorColor = colorscheme.palette.base05;

			icon = str:
				"<span color='#${color}'>${str}</span>";

			iconList = list:
				builtins.map icon list;
		in {
			layer = "bottom";
			position = "top";
			height = 46;
			margin-top = 10;
			margin-left = 10;
			margin-right = 10;
			reload_style_on_change = true;
			output = [ "*" ];
			modules-center = [];

			modules-left = [
				(swayStr "sway/workspaces")
				(swayStr "sway/mode")
				"custom/windowSeparator"
				(swayStr "sway/window")
			];

			modules-right = [
				"cpu"
				"custom/separator"
				"memory"
				"custom/separator"
				"backlight"
				"custom/separator"
				"wireplumber"
				"custom/separator"
				"battery"
				"custom/separator"
				"network"
				"custom/separator"
				"bluetooth"
				"custom/separator"
				"custom/clock"
			];

        	network = {
				tooltip = false;
				format = "${icon "󰈀"} {ifname}";
				format-wifi = "{icon} {essid}";
				format-ethernet = "${icon "󰈀"} on";
				format-disconnected = "${icon "󰤭"} off";
				format-icons = iconList [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
			};

			wireplumber = {
				format-muted = "${icon "󰝟"} Muted";
				format-icons = iconList [ "" "" "" ];
			};

			backlight = {
				tooltip = false;
				format = "{icon} {percent}%";
				format-icons = iconList [ "󰃞" "󰃟" "󰃝" "󰃠" ];
			};

			battery = {
				tooltip = false;
				design-capacity = false;
				format = "{icon} {time} -{capacity}%";
				format_time = "{H}:{m}";
				format-plugged = "{icon} +{capacity}%";
				format-icons = iconList [ "" "" "" "" "" ];
			};

			bluetooth = {
				tooltip = false;
				format = "${icon ""} {status}";
				format-connected = "${icon ""} {device_alias}";
				format-connected-battery = "${icon ""} {device_alias} {device_battery_percentage}%";
				format-disabled = "${icon ""} off";
			};

			"custom/clock" = {
				tooltip = false;
				interval = 60;
				format = "${icon "󰃰"} {} ";
				exec = pkgs.writers.writeDash "date" ''
					set -eu
					${pkgs.toybox}/bin/date "+%b %e %Y (%a) %l:%M %p"
				'';
			};

			"custom/separator" = {
				tooltip = false;
				interval = "once";
				format = " <span color='#${separatorColor}'>|</span> ";
			};

			"custom/windowSeparator" = {
				tooltip = false;
				interval = "once";
				format = "<span color='#${separatorColor}'>|</span> ";
			};

			"custom/uptime" = {
				tooltip = false;
				interval = 60;
				format = "${icon "󰭖"} {} up";
				exec = pkgs.writers.writeDash "uptime" ''
					set -eu
					${pkgs.coreutils}/bin/uptime | ${pkgs.gawk}/bin/gawk '1 {
						gsub(",", "", $3)
						print $3
					}'
				'';
			};

			"custom/user" = {
				tooltip = false;
				interval = 60;
				format = "${icon ""} {}";
				exec = pkgs.writers.writeDash "user" ''
					set -eu
					${pkgs.toybox}/bin/whoami
				'';
			};

			cpu = {
				tooltip = false;
				interval = 5;
				format = "${icon ""} {usage}%";
			};

			memory = {
				tooltip = false;
				interval = 5;
				format = "${icon "󰓌"} {percentage}%";
			};

			"sway/mode" = lib.mkIf sway {
				tooltip = false;
				format = "<span color='#${separatorColor}'>|</span> ${icon "󰂮"} {} ";
			};

			"sway/window" = lib.mkIf sway {
				tooltip = false;
				format = "{title}";
				max-length = 40;
				all-outputs = false;
				icon = true;
				icon-size = 21;
			};

			"sway/workspaces" = lib.mkIf sway {
				tooltip = false;
				format = "{name}";
				all-outputs = true;
				disable-scroll = true;
				disable-click = true;
				disable-scroll-wraparound = true;
				enable-bar-scroll = false;
				warp-on-scroll = false;
			};

			wireplumber = {
				tooltip = false;
				format = "{icon} {volume}%";
			};
		};

		style = ''
			* { border-radius: 0; }
			#workspaces button.focused { background-color: #${colorscheme.palette.base03}; }
			#workspaces button.urgent { background-color: #${colorscheme.palette.base08}; }

			#workspaces button {
				padding-left: 0.5em;
				padding-right: 0.5em;
				color: #${colorscheme.palette.base05};
				border: none;
			}

			#workspaces button:hover {
				box-shadow: inherit;
				text-shadow: inherit;
				transition: unset;
				background: none;
			}

			window#waybar {
				background-color: rgba(59, 66, 82, 0.7);
				color: #${colorscheme.palette.base05};
			}
		'';

		systemd = {
			enable = true;
			target = "sway-session.target";
		};
	};
}
