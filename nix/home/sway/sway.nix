{ config, pkgs, ... }:
{
	wayland.windowManager.sway = {
		xwayland = true;
		systemdIntegration = true;

		wrapperFeatures = {
			base = true;
			gtk = true;
		};

		config = let
			swayConfig = config.wayland.windowManager.sway.config;
			menu = bin: "${swayConfig.terminal} --class 'menu' -e '${pkgs.dash}/bin/dash' -c '${bin} | ${pkgs.busybox}/bin/xargs -r ${pkgs.sway}/bin/swaymsg exec --'";
		in
		{
			modifier = "Mod4";
			left = "h";
			down = "j";
			up = "k";
			right = "l";
			terminal = "${pkgs.alacritty}/bin/alacritty";
			menu = menu "${config.customVars.fzfscripts.pathmenu}/bin/pathmenu";

			colors = {
				background = "#000000";

				focused = {
					border = "#ff0000";
					background = "#ff0000";
					text = "#ff0000";
					indicator = "#5e81ac";
					childBorder = "#5e81ac";
				};

				focusedInactive = {
					border = "#00ff00";
					background = "#00ff00";
					text = "#00ff00";
					indicator = "#81a1c1";
					childBorder = "#81a1c1";
				};

				unfocused = {
					border = "#0000ff";
					background = "#0000ff";
					text = "#0000ff";
					indicator = "#4c566a";
					childBorder = "#4c566a";
				};

				urgent = {
					border = "#00ffff";
					background = "#00ffff";
					text = "#00ffff";
					indicator = "#bf616a";
					childBorder = "#bf616a";
				};

				placeholder = {
					border = "#ffff00";
					background = "#ffff00";
					text = "#ffff00";
					indicator = "#ffff00";
					childBorder = "#ffff00";
				};
			};

			startup = [
				{
					command = "waybar";
				}
				{
					command = "${config.customVars.notifs.musicLoop}/bin/musicLoop";
				}
			];

			keybindings = let
				light = args: "exec sh -c '${pkgs.light}/bin/light ${args} && ${config.customVars.notifs.brightness}/bin/brightness'";
				wpctl = args: "exec sh -c '${pkgs.wireplumber}/bin/wpctl ${args} && ${config.customVars.notifs.volume}/bin/volume'";
			in
			pkgs.lib.mkOptionDefault {
				"Mod4+Return" = "exec ${swayConfig.terminal}";
				"Mod4+w" = "exec ${pkgs.librewolf}/bin/librewolf";
				"Mod4+d" = "exec ${swayConfig.menu}";
				"Mod4+backspace" = "exec ${swayConfig.terminal} --class 'menu' -e -sh -c 'sysmenu | xargs -r swaymsg exec --'";
				F11 = light "-U 1";
				F12 = light "-A 1";
				XF86AudioMute = wpctl "set-mute @DEFAULT_SINK@ toggle";
				XF86AudioLowerVolume = wpctl "set-volume @DEFAULT_SINK@ 1%-";
				XF86AudioRaiseVolume = wpctl "set-volume @DEFAULT_SINK@ 1%+";
				XF86AudioPrev = "exec ${pkgs.mpc-cli}/bin/mpc prev";
				XF86AudioNext = "exec ${pkgs.mpc-cli}/bin/mpc next";
				XF86AudioStop = "exec ${pkgs.mpc-cli}/bin/mpc stop";
				XF86AudioPlay = "exec ${pkgs.mpc-cli}/bin/mpc toggle";
				Print = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy";
				"Print+Shift" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
				"Mod4+q" = "kill";
				"Mod4+Shift+q" = "exit";
				"Mod4+shift+r" = "reload";
				"Mod4+${swayConfig.left}" = "focus left";
				"Mod4+${swayConfig.down}" = "focus down";
				"Mod4+${swayConfig.up}" = "focus up";
				"Mod4+${swayConfig.right}" = "focus right";
				"Mod4+Shift+${swayConfig.left}" = "move left";
				"Mod4+Shift+${swayConfig.down}" = "move down";
				"Mod4+Shift+${swayConfig.up}" = "move up";
				"Mod4+Shift+${swayConfig.right}" = "move right";
				"Mod4+1" = "workspace number 1";
				"Mod4+2" = "workspace number 2";
				"Mod4+3" = "workspace number 3";
				"Mod4+4" = "workspace number 4";
				"Mod4+5" = "workspace number 5";
				"Mod4+6" = "workspace number 6";
				"Mod4+7" = "workspace number 7";
				"Mod4+8" = "workspace number 8";
				"Mod4+9" = "workspace number 9";
				"Mod4+Shift+1" = "move container to workspace number 1";
				"Mod4+Shift+2" = "move container to workspace number 2";
				"Mod4+Shift+3" = "move container to workspace number 3";
				"Mod4+Shift+4" = "move container to workspace number 4";
				"Mod4+Shift+5" = "move container to workspace number 5";
				"Mod4+Shift+6" = "move container to workspace number 6";
				"Mod4+Shift+7" = "move container to workspace number 7";
				"Mod4+Shift+8" = "move container to workspace number 8";
				"Mod4+Shift+9" = "move container to workspace number 9";
				"Mod4+b" = "splith";
				"Mod4+v" = "splitv";
				"Mod4+e" = "layout toggle all";
				"Mod4+f" = "fullscreen";
				"Mod4+Shift+space" = "floating toggle";
				"Mod4+space" = "focus mode_toggle";
				"Mod4+a" = "focus parent";
				"Mod4+Shift+minus" = "move scratchpad";
				"Mod4+minus" = "scratchpad show";
				"Mod4+r" = "mode resize";
			};

			output = {
				eDP-1 = {
					bg = "${./../wallpapers/japanese.png} fill";
				};
			};

			input = {
				"1267:12608:MSFT0001:01_04F3:3140_Touchpad" = {
					dwt = "enabled";
					tap = "enabled";
					natural_scroll = "enabled";
					middle_emulation = "enabled";
				};

				"1:1:AT_Translated_Set_2_keyboard" = {
					xkb_options = "caps:escape";
					repeat_delay = "200";
					repeat_rate = "70";
				};
			};

			modes = {
				resize = {
					${swayConfig.left} = "resize shrink width 10px";
					${swayConfig.down} = "resize grow height 10px";
					${swayConfig.up} = "resize shrink height 10px";
					${swayConfig.right} = "resize grow width 10px";
					Return = "mode default";
					Escape = "mode default";
				};
			};

			window = {
				commands = [
					{
						criteria = {
							app_id = "menu";
						};

						command = "floating enable";
					}
				];

				titlebar = false;
				border = 2;
			};

			gaps = {
				top = 5;
				bottom = 5;
				vertical = 5;
				horizontal = 5;
				inner = 5;
				outer = 5;
				left = 5;
				right = 5;
			};

			floating = {
				modifier = "Mod4";
				titlebar = false;
				border = 2;
			};

			focus = {
				followMouse = false;
				mouseWarping = false;
			};

			seat = {
				"*" = {
					hide_cursor = "5000";
				};
			};

			bars = [];
		};
	};
}
