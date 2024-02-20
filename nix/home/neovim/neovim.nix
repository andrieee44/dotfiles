{ pkgs, ... }:
{
	config.programs.neovim = {
		defaultEditor = true;

		plugins = with pkgs.vimPlugins; [
			{
				plugin = nvim-colorizer-lua;
				config = builtins.readFile ./nvim-colorizer-lua.vim;
			}

			{
				plugin = trim-nvim;
				config = builtins.readFile ./trim-nvim.vim;
			}

			{
				plugin = nvim-treesitter.withAllGrammars;
				config = builtins.readFile ./nvim-treesitter.vim;
			}
		];

		extraLuaConfig = builtins.readFile ./config.lua;
	};
}
