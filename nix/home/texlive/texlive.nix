{ config, lib, ... }:
{
	config = {
		programs.texlive = {
			extraPackages = tpkgs:
			{
				inherit (tpkgs) scheme-full;
			};
		};

		home.file.latexmkrc = lib.mkIf config.programs.texlive.enable {
			executable = false;
			target = "${config.xdg.configHome}/latexmk/latexmkrc";

			text = ''
				$ENV{'TEXMFHOME'} = "${config.xdg.dataHome}/texlive";
				$ENV{'TEXMFCONFIG'} = "${config.xdg.configHome}/texlive";
				$ENV{'TEXMFVAR'} = "${config.xdg.cacheHome}/texlive";
			'';
		};
	};
}
