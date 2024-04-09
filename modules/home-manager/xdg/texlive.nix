{ config, ... }:
{
	xdg.configFile."latexmk/latexmkrc" = {
		enable = config.programs.texlive.enable;

		text = ''
			$ENV{'TEXMFHOME'} = "${config.xdg.dataHome}/texlive";
			$ENV{'TEXMFCONFIG'} = "${config.xdg.configHome}/texlive";
			$ENV{'TEXMFVAR'} = "${config.xdg.cacheHome}/texlive";
		'';
	};
}
