{ pkgs, ... }:
{
	custom.programs.jstat.package = pkgs.buildGoModule rec {
		name = "jstat";
		vendorHash = "sha256-a0lx9owbPGOMjh5lGygaAczJOjVP15p9aV82QYz9990=";
		sourcePath = "${src.name}/cmd/jstat";

		src = pkgs.fetchFromGitHub {
			owner = "andrieee44";
			repo = "jstat";
			rev = "4175e09871d4b7d0ec2bc979ce283a02e03b1e7f";
			hash = "sha256-N8j8i3stV9/ZdrtOkvawxxVm40HVw7liadQGQSZtJxA=";
		};
	};
}
