{ pkgs, ... }:
{
	custom.programs.jsonstatus = {
		package = pkgs.buildGoModule {
			name = "jsonstatus";
			vendorHash = "sha256-7jlGdnOoeVVG7qp5InYnTrwxDHvOVJapiybGgopIjYE=";

			src = pkgs.fetchFromGitHub {
				owner = "andrieee44";
				repo = "jsonstatus";
				rev = "fda6f8b1778090ae78c5f7765a98095f784b78ae";
				hash = "sha256-/ux5LdgiykAW/6Wh7b+ADnn3+N8374O20h5X34eNsbI=";
			};
		};

		settings = {
			user.enable = false;

			date = {
				enable = true;
				interval = "1s";
				format = "Jan _2 2006 (Mon) 3:04 PM";
				icons = [ "󱑊" "󱐿" "󱑀" "󱑁" "󱑂" "󱑃" "󱑄" "󱑅" "󱑆" "󱑇" "󱑈" "󱑉" ];
			};

			ram = {
				enable = true;
				interval = "1s";
				icons = [ " " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
			};

			swap = {
				enable = false;
				interval = "1s";
				icons = [ " " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
			};

			cpu = {
				enable = true;
				interval = "1s";
				icons = [ " " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
			};

			bri = {
				enable = true;
				icons = [ "󰃞" "󰃟" "󰃝" "󰃠" ];
			};

			bat = {
				enable = true;
				interval = "1s";
				icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
			};

			music = {
				enable = true;
				scrollInterval = "0.5s";
				format = "%AlbumArtist% - %Track% - %Album% - %Title%";
				limit = 20;
			};

			vol = {
				enable = true;
				discardInterval = "10ms";
				icons = [ "󰕿" "󰖀" "󰕾" ];
			};

			uptime = {
				enable = false;
				interval = "1s";
			};

			disk = {
				enable = false;
				interval = "1m";
				disks = [ "/" ];
				icons = [ " " "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
			};

			hyprland = {
				enable = true;
				scrollInterval = "0.5s";
				limit = 20;
			};

			net = {
				enable = true;
				interval = "1s";
				scrollInterval = "0.5s";
				limit = 20;
				offIcon = "󰤭";
				ethIcon = "󰈀";
				wifiIcons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
			};

			bluetooth = {
				enable = true;
				scrollInterval = "0.5s";
				limit = 5;
				icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
			};
		};
	};
}
