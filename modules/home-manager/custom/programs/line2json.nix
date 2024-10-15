{ pkgs, ... }:
{
	custom.programs.line2json.package = pkgs.buildGoModule {
		name = "line2json";
		vendorHash = null;

		src = pkgs.fetchFromGitHub {
			owner = "andrieee44";
			repo = "line2json";
			rev = "6af17b584d7d3b1cf342e71ac60272617e7707de";
			hash = "sha256-h0xLK4TDDaSFYZRWAmZnlQIWAyFE7rUne1fcmPbE5Z4=";
		};
	};
}
