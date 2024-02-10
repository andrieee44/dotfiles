{ config, pkgs, ... }:
{
	config = {
		programs.neovim = {
			defaultEditor = true;

			plugins = with pkgs.vimPlugins; [
				{
					plugin = nvim-colorizer-lua;
					config =  builtins.readFile ./nvim-colorizer-lua.vim;
				}

				{
					plugin = trim-nvim;
					config =  builtins.readFile ./trim-nvim.vim;
				}

				{
					plugin = nvim-treesitter.withAllGrammars;
					config =  builtins.readFile ./nvim-treesitter.vim;
				}
			];

			extraLuaConfig = ''
				local env = vim.env
				local opt = vim.opt
				local api = vim.api
				local bo = vim.bo
				local keymap = api.nvim_set_keymap
				local mkAugroup = api.nvim_create_augroup
				local mkAutocmd = api.nvim_create_autocmd

				opt.mouse = ${"''"}
				opt.showmode = false
				opt.tabstop = 4
				opt.shiftwidth = 0
				opt.syntax = 'enable'
				opt.smartindent = true
				opt.smartcase = true
				opt.number = true
				opt.relativenumber = true
				opt.compatible = false
				opt.wildmode = 'longest,list,full'
				opt.background = 'dark'
				opt.clipboard:append('unnamedplus')
				opt.complete:append('kspell')
				opt.signcolumn = 'yes'

				keymap('n', 'ZW', ':w<CR>', {
					noremap = true,
				})

				keymap('n', 'ZE', ':e<CR>', {
					noremap = true,
				})

				keymap('c', 'w!!', 'w !${pkgs.sudo}/bin/sudo ${config.customVars.unixUtils}/tee > /dev/null %', {
					noremap = true,
				})

				local function filetypeSettings()
					bo.formatoptions = bo.formatoptions:gsub('[cro]', ${"''"})
				end

				local filetypeAugroup = mkAugroup('filetypeAugroup', {})

				mkAutocmd('FileType', {
					callback = filetypeSettings,
					group = filetypeAugroup,
				})

				local function mailSettings()
					opt.colorcolumn = 76
					opt.textwidth = 75
					opt.spell = true
					opt.spelllang = 'en'
				end

				local mailAugroup = mkAugroup('mailAugroup', {})

				mkAutocmd('FileType', {
					callback = mailSettings,
					group = mailAugroup,

					pattern = {
						'mail',
					},
				})

				local function termguicolorsSettings()
					opt.termguicolors = env.TERM == 'tmux-256color'
				end

				local termguicolorsAugroup = mkAugroup('termguicolorsAugroup', {})

				mkAutocmd('VimEnter', {
					callback = termguicolorsSettings,
					group = termguicolorsAugroup,
				})
			'';
		};
	};
}
