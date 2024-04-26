{ config, pkgs, lib, colorscheme, ... }:
{
	home.sessionVariables.PAGER = lib.optionalString config.programs.nixvim.enable "nvim -R";

	programs.nixvim = {
		defaultEditor = true;
		globals.mapleader = " ";

		autoCmd = [
			{ event = [ "FileType" ];

				callback.__raw = ''
					function()
						vim.bo.formatoptions = vim.bo.formatoptions:gsub('[cro]', ${"''"})
					end
				'';
			}

			{
				event = [ "FileType" ];
				pattern = [ "mail" ];

				callback.__raw = ''
					function()
						vim.opt.colorcolumn = '75'
						vim.opt.textwidth = 75
						vim.opt.spell = true
						vim.opt.spelllang = 'en'
					end
				'';
			}

			{
				event = [ "VimEnter" ];

				callback.__raw = ''
					function()
						local customColors = {
							nord = function()
								vim.api.nvim_set_hl(0, 'LineNr', {
									ctermfg = 'cyan',
									fg = '#${colorscheme.palette.base0C}',
								})

								vim.api.nvim_set_hl(0, 'Visual', {
									ctermfg = 'darkgray',
									ctermbg = 'white',
									bg = '#${colorscheme.palette.base03}',
								})

								vim.api.nvim_set_hl(0, 'Comment', {
									ctermfg = 'blue',
									fg = '#${colorscheme.palette.base0D}',
									italic = true,
								})
							end,
						}

						if customColors[vim.g.colors_name] then
							customColors[vim.g.colors_name]()
						end
					end
				'';
			}
		];

		clipboard = {
			providers.wl-copy.enable = true;
			register = "unnamedplus";
		};

		colorschemes = lib.attrsets.recursiveUpdate {
			nord.settings.disable_background = true;
		} { ${colorscheme.slug}.enable = true; };

		highlightOverride = {
			DiagnosticSignError = {
				ctermfg = "red";
				fg = "#${colorscheme.palette.base08}";
				bold = true;
			};

			DiagnosticVirtualTextError.link = "DiagnosticSignError";
			DiagnosticFloatingError.link = "DiagnosticSignError";

			DiagnosticSignWarn = {
				ctermfg = "yellow";
				fg = "#${colorscheme.palette.base0A}";
				bold = true;
			};

			DiagnosticVirtualTextWarn.link = "DiagnosticSignWarn";
			DiagnosticFloatingWarn.link = "DiagnosticSignWarn";
		};

		keymaps = [
			{
				mode = [ "n" ];
				key = "ZW";
				action = "<cmd>w<CR>";
				options = { noremap = true; };
			}

			{
				mode = [ "n" ];
				key = "ZE";
				action = "<cmd>e<CR>";
				options = { noremap = true; };
			}
		];

		opts = {
			mouse = "";
			showmode = false;
			tabstop = 4;
			shiftwidth = 0;
			syntax = "enable";
			smartindent = true;
			smartcase = true;
			number = true;
			relativenumber = true;
			compatible = false;
			wildmode = "longest,list,full";
			background = "dark";
			signcolumn = "yes";

			completeopt = [
				"menu"
				"menuone"
				"noselect"
			];
		};

		extraPlugins = with pkgs.vimPlugins; [
			{
				plugin = nvim-web-devicons;
				config = ''lua require('nvim-web-devicons').setup()'';
			}

			{
				plugin = trim-nvim;
				config = ''lua require('trim').setup({ patterns = { [=[%s/\(\n\n\)\n\+/\1/]=] } })'';
			}

			(pkgs.vimUtils.buildVimPlugin {
				name = "oishiline";

				src = pkgs.fetchFromGitHub {
					owner = "andrieee44";
					repo = "oishiline";
					rev = "a3c138c100584ac570397bc1e4b7859a75826c12";
					hash = "sha256-2hFi7Rxo7c7qeZ7Z0l5TXFFFnpIQ39bRJq2ML8PQiNI=";
				};
			})
		];

		extraConfigLua = ''
			vim.opt.termguicolors = vim.env.XDG_SESSION_TYPE ~= 'tty'

			local signs = {
				Error = vim.opt.termguicolors._value and ' ' or '! ',
				Warn = vim.opt.termguicolors._value and ' ' or '? ',
				Hint = vim.opt.termguicolors._value and ' ' or '* ',
				Info = vim.opt.termguicolors._value and ' ' or 'i ',
			}

			for k, v in pairs(signs) do
				local name = string.format('DiagnosticSign%s', k)

				vim.fn.sign_define(name, {
					text = v,
					texthl = name,
					numhl = string.format('DiagnosticVirtualText%s', k),
				})
			end

			vim.diagnostic.config({
				severity_sort = true,

				virtual_text = {
					prefix = ${"''"},

					format = function(diagnostic)
						local severity = vim.diagnostic.severity

						local severityStr = {
							[severity.ERROR] = 'Error',
							[severity.WARN] = 'Warn',
							[severity.HINT] = 'Hint',
							[severity.INFO] = 'Info',
						}

						local sign = vim.fn.sign_getdefined(string.format('DiagnosticSign%s', severityStr[diagnostic.severity]))

						return string.format('%s%s', sign[1].text, diagnostic.message)
					end,
				},
			})

			require('oishiline').setup({
				colors = {
					black = '#${colorscheme.palette.base00}',
					red = '#${colorscheme.palette.base08}',
					green = '#${colorscheme.palette.base0B}',
					yellow = '#${colorscheme.palette.base0A}',
					blue = '#${colorscheme.palette.base0D}',
					magenta = '#${colorscheme.palette.base0E}',
					cyan = '#${colorscheme.palette.base0C}',
					white = '#${colorscheme.palette.base05}',
					brightBlack = '#${colorscheme.palette.base03}',
					brightRed = '#${colorscheme.palette.base08}',
					brightGreen = '#${colorscheme.palette.base0B}',
					brightYellow = '#${colorscheme.palette.base0A}',
					brightBlue = '#${colorscheme.palette.base0D}',
					brightMagenta = '#${colorscheme.palette.base0E}',
					brightCyan = '#${colorscheme.palette.base0C}',
					brightWhite = '#${colorscheme.palette.base07}',
				},
			})
		'';

		plugins = let
			plugins = config.programs.nixvim.plugins;
		in {
			cmp-nvim-lsp.enable = true;

			cmp = {
				enable = true;

				cmdline = {
					":" = {
						mapping.__raw = "cmp.mapping.preset.cmdline()";

						sources = [
							{ name = "path"; }
							{ name = "cmdline"; }
						];
					};

					"/" = {
						mapping.__raw = "cmp.mapping.preset.cmdline()";
						sources = [ { name = "buffer"; } ];
					};

					"?" = {
						mapping.__raw = "cmp.mapping.preset.cmdline()";
						sources = [ { name = "buffer"; } ];
					};
				};

				settings = {
					mapping = {
						"<C-j>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
						"<C-k>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
						"<C-Space>" = "cmp.mapping.complete()";
						"<C-e>" = "cmp.mapping.abort()";
						"<CR>" = "cmp.mapping.confirm({ select = true })";
					};

					snippet.expand = ''
						function(args)
							require('luasnip').lsp_expand(args.body)
						end
					'';

					sources = [
						{ name = "nvim-lspconfig"; }
						{ name = "luasnip"; }
						{ name = "buffer"; }
					];
				};
			};

			lsp = {
				enable = true;
				capabilities = lib.optionalString plugins.cmp-nvim-lsp.enable "capabilities = require('cmp_nvim_lsp').default_capabilities()";

				keymaps = {
					diagnostic = {
						"<leader>j" = "goto_next";
						"<leader>k" = "goto_prev";
					};

					lspBuf = {
						"<Leader>d" = "definition";
						"<Leader>D" = "type_definition";
						"<Leader>i" = "implementation";
						"<Leader>h" = "hover";
						"<Leader>R" = "references";
						"<Leader>r" = "rename";
						"<Leader>a" = "code_action";
						"<Leader>f" = "format";
					};
				};

				servers = {
					bashls.enable = true;
					gopls.enable = true;
					ltex.enable = true;
					lua-ls.enable = true;
					nil_ls.enable = true;
				};
			};

			nvim-colorizer = {
				enable = true;

				userDefaultOptions = {
					RGB = true;
					RRGGBB = true;
					names = true;
					RRGGBBAA = true;
					rgb_fn = true;
					hsl_fn = true;
					css = true;
					css_fn = true;
					mode = "background";
				};
			};

			treesitter = {
				enable = true;
				nixvimInjections = true;
			};
		};
	};
}
