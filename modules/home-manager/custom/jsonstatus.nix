{
	custom.programs.jsonstatus.settings = {
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
}
