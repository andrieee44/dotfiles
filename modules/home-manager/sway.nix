{ config, pkgs, ... }:
{
	wayland.windowManager.sway = {
		xwayland = true;
		systemd.enable = true;

		wrapperFeatures = {
			base = true;
			gtk = true;
		};

		config = let
			swayConfig = config.wayland.windowManager.sway.config;
			mkMenu = cmd:
				''${swayConfig.terminal} --class "menu" -e "${pkgs.dash}/bin/dash" -c "${cmd} | ${pkgs.toybox}/bin/xargs -r ${pkgs.sway}/bin/swaymsg exec --"'';
		in {
			modifier = "Mod4";
			left = "h";
			down = "j";
			up = "k";
			right = "l";
			terminal = "${pkgs.alacritty}/bin/alacritty";
			menu = mkMenu "${config.sh.pathmenu}/bin/pathmenu";

			keybindings = let
				light = args:
					"exec ${pkgs.light}/bin/light ${args}";

				wpctl = args:
					"exec ${pkgs.wireplumber}/bin/wpctl ${args}";

				mpc = args:
					"exec ${pkgs.mpc-cli}/bin/mpc ${args}";

				grimshot = args:
					"exec ${pkgs.sway-contrib.grimshot}/bin/grimshot ${args}";
			in pkgs.lib.mkOptionDefault {
				"Mod4+Return" = "exec ${swayConfig.terminal}";
				"Mod4+w" = "exec ${pkgs.librewolf}/bin/librewolf";
				"Mod4+d" = "exec ${swayConfig.menu}";
				"Mod4+BackSpace" = "exec ${mkMenu "${config.sh.sysmenu}/bin/sysmenu"}";
				F9 = "exec ${pkgs.systemd}/bin/loginctl lock-session";
				F11 = light "-U 1";
				F12 = light "-A 1";
				XF86AudioMute = wpctl "set-mute @DEFAULT_SINK@ toggle";
				XF86AudioLowerVolume = wpctl "set-volume @DEFAULT_SINK@ 1%-";
				XF86AudioRaiseVolume = wpctl "set-volume @DEFAULT_SINK@ 1%+";
				XF86AudioPrev = mpc "prev";
				XF86AudioNext = mpc "next";
				XF86AudioStop = mpc "stop";
				XF86AudioPlay = mpc "toggle";
				Print = grimshot "copy";
				"Print+Shift" = grimshot "copy area";
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

			input = {
				"type:touchpad" = {
					dwt = "enabled";
					tap = "enabled";
					natural_scroll = "enabled";
					middle_emulation = "enabled";
					events = "disabled_on_external_mouse";
				};

				"type:keyboard" = {
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
						criteria.app_id = "menu";
						command = "floating enable";
					}

					{
						criteria.shell = ".*";
						command = "inhibit_idle fullscreen";
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
					xcursor_theme = let
						cursorTheme = config.gtk.cursorTheme;
					in "${cursorTheme.name} ${builtins.toString cursorTheme.size}";

					hide_cursor = "5000";
				};
			};

			bars = [];
		};
	};
}
