{ config, pkgs, lib, ... }:
{
	config.programs.neovim = {
		plugins = with pkgs.vimPlugins; [
			(lib.mkIf (config.customVars.colorscheme == "nord") {
				plugin = nord-nvim;

				config = ''
					lua <<EOF
						local g = vim.g
						local api = vim.api
						local mkAugroup = api.nvim_create_augroup
						local mkAutocmd = api.nvim_create_autocmd

						local function nordSettings()
							local hl = api.nvim_set_hl

							hl(0, 'Visual', {
								ctermfg = 'black',
								ctermbg = 'white',
								bg = '#4c566a',
							})

							hl(0, 'LineNr', {
								ctermfg = 'blue',
								fg = '#81a1c1',
							})

							hl(0, '@comment', {
								ctermfg = 'blue',
								fg = '#81a1c1',
								italic = true,
							})

							hl(0, 'Comment', {
								ctermfg = 'blue',
								fg = '#81a1c1',
								italic = true,
							})
						end

						local nordAugroup = mkAugroup('nordAugroup', {})

						mkAutocmd('ColorScheme', {
							callback = nordSettings,
							group = nordAugroup,

							pattern = {
								'nord',
							},
						})

						g.nord_disable_background = true
						require('nord').set()
EOF
				'';
			})
			{
				plugin = lightline-vim;

				config = let
					nordTheme = string:
					lib.optionalString (config.customVars.colorscheme == "nord") string;
				in ''
					lua <<EOF
						${nordTheme ''
							local function copyTable(datatable)
								local tblRes={}
								if type(datatable)=="table" then
									for k,v in pairs(datatable) do tblRes[k]=copyTable(v) end
								else
									tblRes=datatable
								end
								return tblRes
							end

							local function nordCustom()
								local tmp = vim.g['lightline#colorscheme#nord#palette']

								tmp.normal.left = {
									{ '#3b4252', '#88C0D0', 0, 6, 'bold', },
									{ '#e5e9f0', '#3B4252', 7, 0, },
									{ '#3b4252', '#88C0D0', 0, 6, },
								}

								tmp.visual.left = copyTable(tmp.normal.left)
								tmp.visual.left[1][2] = '#a3be8c'
								tmp.visual.left[1][4] = '2'

								tmp.insert.left = copyTable(tmp.normal.left)
								tmp.insert.left[1][2] = '#eceff4'
								tmp.insert.left[1][4] = '7'

								tmp.replace.left = copyTable(tmp.normal.left)
								tmp.replace.left[1][2] = '#ebcb8b'
								tmp.replace.left[1][4] = '3'

								tmp.normal.right = {
									{ '#e5e9f0', '#4c566a', 7, 8, },
								}

								tmp.normal.error[1] = { '#e5e9f0', '#bf616a', 7, 1, 'bold' }
								tmp.normal.warning[1] = { '#3b4252', '#ebcb8b', 0, 3, 'bold' }

								tmp.normal.middle = {{ '#e5e9f0', '#3b4252', 7, 8, },}
								tmp.visual.middle = copyTable(tmp.normal.middle)
								tmp.insert.middle = copyTable(tmp.normal.middle)
								tmp.replace.middle = copyTable(tmp.normal.middle)

								vim.g['lightline#colorscheme#nord#palette'] = tmp
							end
						''}

						local function lightlineSettings()
							local fn = vim.fn
							local g = vim.g
							local diagnostic = vim.diagnostic
							local severity = diagnostic.severity
							local getD = diagnostic.get
							local nerdFont = os.getenv('XDG_SESSION_TYPE') == 'tty' and ${if config.customVars.colorscheme == "nord" then
								"true" else "false"
							}

							if not fn.exists('g:loaded_lightline') then
								return
							end

							g.lspStatusline = {
								error = function()
									local n = #(getD(0, {
										severity = severity.ERROR
									}))

									if n == 0 then
										return ${"''"}
									end

									return string.format('E: %d', n)
								end,

								warn = function()
									local n = #(getD(0, {
										severity = severity.WARN
									}))

									if n == 0 then
										return ${"''"}
									end

									return string.format('W: %d', n)
								end,
							}

							g.lightline = {
								colorscheme = g.colors_name,

								component_expand = {
									error = 'g:lspStatusline.error',
									warn = 'g:lspStatusline.warn',
								},

								component_type = {
									error = 'error',
									warn = 'warning',
								},

								separator = {
									left = not nerdFont and '' or ' ',
									right = not nerdFont and '' or ' ',
								},

								subseparator = {
									left = not nerdFont and '' or '|',
									right = not nerdFont and '' or '|',
								},

								active = {
									left = {
										{
											'mode',
											'paste',
										},
										{
										},
										{
											'filename',
											'readonly',
											'modified',
										},
									},

									right = {
										{
											'error',
											'warn',
											'fileformat',
											'fileencoding',
											'filetype',
											'lineinfo',
											'percent',
										},
									},
								},
							}

							fn['lightline#init']()
							fn['lightline#colorscheme']()
							${nordTheme "nordCustom()"}
							fn['lightline#update']()
						end

						local api = vim.api
						local mkAugroup = api.nvim_create_augroup
						local mkAutocmd = api.nvim_create_autocmd

						local lightlineAugroup = mkAugroup('lightlineAugroup', {})

						mkAutocmd('VimEnter', {
							callback = lightlineSettings,
							group = lightlineAugroup,
						})

						mkAutocmd('ColorScheme', {
							callback = lightlineSettings,
							group = lightlineAugroup,
						})

						mkAutocmd('DiagnosticChanged', {
							callback = function()
								local fn = vim.fn

								fn['lightline#update']()
							end,

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
				plugin = trim-nvim;

				config = ''
					lua <<EOF
						require('trim').setup()
EOF
				'';
			}
			{
				plugin = nvim-treesitter.withAllGrammars;

				config = ''
					lua <<EOF
						require('nvim-treesitter.configs').setup({
							highlight = {
								enable = true,
							},
						})
EOF
				'';
			}
			{
				plugin = nvim-lspconfig;

				config = let
					setup = name: pname:
					lib.optionalString (builtins.any (pkg:
					pkg == pname
					) config.programs.neovim.extraPackages) "setup('${name}')";
				in ''
					lua <<EOF
						local set = vim.keymap.set
						local api = vim.api
						local diagnostic = vim.diagnostic
						local o = vim.o
						local mkAutocmd = api.nvim_create_autocmd
						local mkAugroup = api.nvim_create_augroup

						local function setup(server)
							require('lspconfig')[server].setup({})
						end

						${setup "nil_ls" pkgs.nil}
						${setup "gopls" pkgs.gopls}
						${setup "bashls" pkgs.nodePackages_latest.bash-language-server}

						diagnostic.config({
							signs = false
						})

						o.updatetime = 250

						set('n', '[d', vim.diagnostic.goto_prev)
						set('n', ']d', vim.diagnostic.goto_next)

						local lspAugroup = mkAugroup('lspAugroup', {})

						local function floatDiagnostic()
							diagnostic.open_float(nil, {focus=false})
						end

						mkAutocmd({'CursorHold', 'CursorHoldI'}, {
							callback = floatDiagnostic,
							group = LspAugroup,
						})

						local function lspSettings(ev)
							local set = vim.keymap.set

							vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

							local opts = {
								buffer = ev.buf
							}

							set('n', 'gd', vim.lsp.buf.definition, opts)
							set('n', 'K', vim.lsp.buf.hover, opts)
							set('n', 'gi', vim.lsp.buf.implementation, opts)
							set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
							set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
							set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
							set('n', '<space>D', vim.lsp.buf.type_definition, opts)
							set('n', '<space>rn', vim.lsp.buf.rename, opts)
							set({'n', 'v'}, '<space>ca', vim.lsp.buf.code_action, opts)
							set('n', 'gr', vim.lsp.buf.references, opts)

							set('n', '<space>wl', function()
								print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
							end, opts)

							vim.keymap.set('n', '<space>f', function()
								vim.lsp.buf.format({
									async = true
								})
							end, opts)
						end

						mkAutocmd('LspAttach', {
							callback = lspSettings,
							group = LspAugroup,
						})
EOF
				'';
			}
		];

		extraPackages = with pkgs; [
			nodePackages_latest.bash-language-server
			shellcheck
			nil
			gopls
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

			keymap('n', 'ZW', ':w<CR>', {
				noremap = true,
			})

			keymap('n', 'ZE', ':e<CR>', {
				noremap = true,
			})

			keymap('c', 'w!!', 'w !${pkgs.sudo}/bin/sudo ${config.customVars.unixUtils}/tee >/dev/null %', {
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
}
