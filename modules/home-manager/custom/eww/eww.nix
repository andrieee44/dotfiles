{ pkgs, ... }:
let
	jsonstatus = pkgs.buildGoModule {
		name = "jsonstatus";
		vendorHash = "sha256-GzK4Jj65P0zNLmFjLM0jTE/Ls5VD6Tim3kzMKTE+wuE=";

		src = pkgs.fetchFromGitHub {
			owner = "andrieee44";
			repo = "jsonstatus";
			rev = "2ce684d4b1a8f5e0826cac5626fc5cc44714010c";
			hash = "sha256-fnrS07PNJ4De551DrillpNsfCJ6X17ZjqxBKJnMfLfE=";
		};
	};
in {
	custom.programs.eww.yuck = builtins.readFile (pkgs.runCommand "eww.yuck" {} ''
		substitute "${./eww.yuck}" "$out" --replace-fail "jsonstatus" "${jsonstatus}/bin/jsonstatus"
	'');
}
