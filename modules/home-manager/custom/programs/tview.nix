{ pkgs, ... }:
{
	custom.programs.tview.package = pkgs.buildGoModule {
		name = "tview";
		vendorHash = "sha256-fNqRD8Y56cr87G1V4+M0TWWJF2D9YfGPQ/obcUU4CG8=";

		src = pkgs.fetchFromGitHub {
			owner = "andrieee44";
			repo = "tview";
			rev = "f220962c1bb0bf4158becbd88e9e11bb44ea3796";
			hash = "sha256-E+x+tdvgpI6M38lyv2/hI+L+M7Cw72qUucF1flngdbo=";
		};
	};
}
