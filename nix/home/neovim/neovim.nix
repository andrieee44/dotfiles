{ config, pkgs, ... }:
{
	config.programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			{
				plugin = nord-vim;

				config = ''
					if ($TERM == "tmux-256color")
						set termguicolors
						augroup clearbg
							autocmd!
							autocmd ColorScheme nord highlight Normal guibg=none
							autocmd ColorScheme nord highlight NonText guibg=none
						augroup END
					endif

					augroup nord
						autocmd!
						autocmd vimenter * ++nested colorscheme nord
						autocmd ColorScheme nord highlight Visual ctermfg=black ctermbg=white guibg=#4c566a
						autocmd ColorScheme nord highlight Comment ctermfg=blue guifg=#81a1c1
						autocmd ColorScheme nord highlight LineNr ctermfg=blue guifg=#81a1c1
					augroup END

				'';
			}
			{
				plugin = vim-airline;
				config = "let g:airline_symbols_ascii = 1";
			}
			{
				plugin = colorizer;
			}
		];

		extraConfig = ''
			set tabstop=4
			set shiftwidth=4
			set smartindent
			set smartcase
			set number relativenumber
			set wildmode=longest,list,full
			set clipboard+=unnamedplus
			set nocompatible
			set background=dark

			nnoremap ZW :w<cr>
			nnoremap ZE :e<cr>
			cmap w!! w !sudo tee >/dev/null %

			filetype plugin indent on
			filetype plugin on
			syntax enable
			set complete+=kspell

			augroup filetype
				autocmd!
				autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
				autocmd FileType mail set colorcolumn=76
				autocmd FileType mail set tw=75
				autocmd FileType mail set spell spelllang=en
			augroup END
		'';
	};
}
