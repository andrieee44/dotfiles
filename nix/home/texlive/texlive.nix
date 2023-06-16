{ config, lib, ... }:
{
	config = {
		programs.texlive = {
			extraPackages = tpkgs:
			{
				inherit (tpkgs) scheme-full;
			};
		};

		xdg.configFile.latexmkrc = lib.mkIf config.programs.texlive.enable {
			target = "latexmk/latexmkrc";

			text = ''
				$ENV{'TEXMFHOME'} = "${config.xdg.dataHome}/texlive";
				$ENV{'TEXMFCONFIG'} = "${config.xdg.configHome}/texlive";
				$ENV{'TEXMFVAR'} = "${config.xdg.cacheHome}/texlive";
			'';
		};
	};
}
