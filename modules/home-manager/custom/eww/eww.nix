{ pkgs, ... }:
let
	jsonstatus = pkgs.buildGoModule {
		name = "jsonstatus";
		vendorHash = "sha256-GzK4Jj65P0zNLmFjLM0jTE/Ls5VD6Tim3kzMKTE+wuE=";

		src = pkgs.fetchFromGitHub {
			owner = "andrieee44";
			repo = "jsonstatus";
			rev = "0d7967e4af6cdb0e14115f48d0fb57c2ca8ec573";
			hash = "sha256-fnrS07PNJ4De551DrillpNsfCJ6X17ZjqxBKJnMfLfE=";
		};
	};
in {
	custom.programs.eww.yuck = builtins.readFile (pkgs.runCommand "eww.yuck" {} ''
		substitute "${./eww.yuck}" "$out" --replace-fail "jsonstatus" "${jsonstatus}/bin/jsonstatus"
	'');
}
