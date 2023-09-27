{ config, lib, pkgs, ... }:
{
	config.programs.waybar = let
		nerdFontStr = config.customVars.fonts.nerdFontStr;
		sway = config.wayland.windowManager.sway.enable;
		swayStr = lib.optionalString sway;
	in {
		settings.mainBar = let
			shShebang = config.customVars.shShebang;
			unixUtils = config.customVars.unixUtils;
		in {
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
			};

			battery = {
				tooltip = false;
				design-capacity = false;
				format = "{icon} -{capacity}%";
				format-plugged = "{icon} +{capacity}%";
			};

			bluetooth = {
				tooltip = false;
				format-disabled = "";
			};

			"custom/clock" = {
				tooltip = false;
				interval = 60;
				exec = pkgs.writeScript "date" ''${shShebang}
					${unixUtils}/date "+${config.customVars.dateFmt}"
				'';
			};

			"custom/separator" = {
				tooltip = false;
				interval = "once";
			};

			"custom/uptime" = {
				tooltip = false;
				interval = 60;
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
				exec = pkgs.writeScript "user" ''${shShebang}
					${unixUtils}/whoami
				'';
			};

			cpu = {
				tooltip = false;
				interval = 5;
			};

			memory = {
				tooltip = false;
				interval = 5;
			};

			network = {
				tooltip = false;
				format = "{essid}";
				format-wifi = "{icon} {essid}";
			};

			"sway/mode" = lib.mkIf sway {
				tooltip = false;
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
				font-size: 14pt;
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
