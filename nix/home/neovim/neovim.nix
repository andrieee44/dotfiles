{ config, pkgs, ... }:
{
	config.programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			{
				plugin = nord-vim;

				config = ''
				lua <<EOF
					if vim.env.TERM == "tmux-256color" then
						vim.opt.termguicolors = true

						vim.cmd([[
							augroup clearbg
								autocmd!
								autocmd ColorScheme nord highlight Normal guibg=none
								autocmd ColorScheme nord highlight NonText guibg=none
							augroup END
						]])
					end

					vim.cmd([[
						augroup nord
							autocmd!
							autocmd VimEnter * ++nested colorscheme nord
							autocmd ColorScheme nord highlight Visual ctermfg=black ctermbg=white guibg=#4c566a
							autocmd ColorScheme nord highlight Comment ctermfg=blue guifg=#81a1c1
							autocmd ColorScheme nord highlight LineNr ctermfg=blue guifg=#81a1c1
						augroup END
					]])
EOF
				'';
			}
			{
				plugin = vim-airline;

				config = ''
					lua vim.g.airline_symbols_ascii = 1
				'';
			}
			{
				plugin = colorizer;
			}
		];

		extraLuaConfig = ''
			local opt = vim.opt
			opt.tabstop = 4
			opt.shiftwidth = 0
			opt.syntax = "enable"
			opt.smartindent = true
			opt.smartcase = true
			opt.number = true
			opt.relativenumber = true
			opt.compatible = false
			opt.wildmode = "longest,list,full"
			opt.background = "dark"
			opt.clipboard:append("unnamedplus")
			opt.complete:append("kspell")

			local keymap = vim.api.nvim_set_keymap
			keymap("n", "ZW", ":w<CR>", { noremap = true })
			keymap("n", "ZE", ":e<CR>", { noremap = true })
			keymap("c", "w!!", "w !${pkgs.sudo}/bin/sudo ${pkgs.busybox}/bin/tee >/dev/null %", { noremap = true })

			local cmd = vim.cmd
			cmd([[filetype plugin indent on]])
			cmd([[
				augroup filetype
					autocmd!
					autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
					autocmd FileType mail set colorcolumn=76
					autocmd FileType mail set tw=75
					autocmd FileType mail set spell spelllang=en
				augroup END
			]])
		'';
	};
}
