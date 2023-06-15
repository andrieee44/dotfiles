{ config, pkgs, ... }:
{
	config.programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			{
				plugin = nord-nvim;

				config = ''
					lua <<EOF
						local g = vim.g
						local api = vim.api

						local function nordTheme()
							local hl = api.nvim_set_hl

							hl(0, 'Visual', {
								ctermfg = 'black',
								ctermbg = 'white',
								bg = '#4c566a',
							})

							hl(0, 'Comment', {
								ctermfg = 'blue',
								fg = '#81a1c1',
							})

							hl(0, 'LineNr', {
								ctermfg = 'blue',
								fg = '#81a1c1',
							})
						end

						local nordAugroup = api.nvim_create_augroup('nord', {})

						api.nvim_create_autocmd('ColorScheme nord', {
							callback = nordTheme,
							group = nordAugroup,

							pattern = {
								'nord',
							},
						})

						g.nord_disable_background = true
						require('nord').set()
EOF
				'';
			}
			{
				plugin = lightline-vim;

				config = ''
					lua <<EOF
						local g = vim.g
						local api = vim.api

						local function lightlineUpdate()
							local fn = vim.fn

							if not fn.exists('g:loaded_lightline') then
								return
							end

							g.lightline = {
								colorscheme = g.colors_name
							}

							fn['lightline#init']()
							fn['lightline#colorscheme']()
							fn['lightline#update']()
						end

						local lightlineAugroup = api.nvim_create_augroup('lightline', {})

						api.nvim_create_autocmd('ColorScheme', {
							callback = lightlineUpdate,
							group = lightlineAugroup,
						})
EOF
				'';
			}
			{
				plugin = vim-hexokinase;

				config = ''
					lua <<EOF
						local g = vim.g

						g.Hexokinase_highlighters = {
							'background',
						}
EOF
				'';
			}
			{
				plugin = vim-sleuth;
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

			if env.TERM == 'tmux-256color' then
				opt.termguicolors = true
			end

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

			keymap('n', 'ZW', ':w<CR>', {
				noremap = true,
			})

			keymap('n', 'ZE', ':e<CR>', {
				noremap = true,
			})

			keymap('c', 'w!!', 'w !${pkgs.sudo}/bin/sudo ${pkgs.busybox}/bin/tee >/dev/null %', {
				noremap = true,
			})

			local function filetypeSettings()
				bo.formatoptions = bo.formatoptions:gsub('[cro]', ${"''"})
			end

			local filetypeAugroup = mkAugroup('filetype', {})

			mkAutocmd('FileType', {
				callback = filetypeSettings,
				group = filetypeAugroup,

				pattern = {
					'*',
				},
			})

			local function mailSettings()
				opt.colorcolumn = 76
				opt.textwidth = 75
				opt.spell = true
				opt.spelllang = 'en'
			end

			local mailAugroup = mkAugroup('mail', {})

			mkAutocmd('FileType', {
				callback = mailSettings,
				group = mailAugroup,

				pattern = {
					'mail',
				},
			})
		'';
	};
}
