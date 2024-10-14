{ pkgs, ... }:
{
	custom.programs.line2json.package = pkgs.buildGoModule {
		name = "line2json";
		vendorHash = null;

		src = pkgs.fetchFromGitHub {
			owner = "andrieee44";
			repo = "line2json";
			rev = "68aceeba360de2e090b398a4e0bc015c197b6da0";
			hash = "sha256-nNg0TP2+/PiEP5J/AMvESUBKy/I+vwRSiVeWOjhNhws=";
		};
	};
}
