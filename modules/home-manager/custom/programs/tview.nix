{ pkgs, ... }:
{
	custom.programs.tview.package = pkgs.buildGoModule {
		name = "tview";
		vendorHash = "sha256-fNqRD8Y56cr87G1V4+M0TWWJF2D9YfGPQ/obcUU4CG8=";

		src = pkgs.fetchFromGitHub {
			owner = "andrieee44";
			repo = "tview";
			rev = "e8e4927970fd8857fb2817a1ef282845fea28b57";
			hash = "sha256-QxKL4+YZOj+srEXBxXn6UUaGHs1fyAjF4igPQH4mfPk=";
		};
	};
}
