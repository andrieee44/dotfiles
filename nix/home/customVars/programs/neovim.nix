{ config, pkgs, lib, ... }:
{
	options.customVars.programs.neovim = let
		mkEnableOption = config.customVars.mkOption lib.types.bool;
	in {
		cmp = {
			enable = mkEnableOption;

			snippet = config.customVars.mkOption (lib.types.enum [
				"luasnip"
			]);
		};

		lspServers = {
			nix = mkEnableOption;
			go = mkEnableOption;
			sh = mkEnableOption;
			lua = mkEnableOption;
			latex = mkEnableOption;
		};
	};

	config = let
		cfg = config.customVars.programs.neovim;
	in {
		customVars.programs.neovim = {
			cmp = {
				enable = true;
				snippet = "luasnip";
			};

			lspServers = {
				nix = true;
				go = true;
				sh = true;
				lua = true;
				latex = true;
			};
		};

		programs.neovim = let
			lspServers = cfg.lspServers;
		in {
			plugins = let
				nerdFontLuaVar = ''
					local nerdFont = os.getenv('XDG_SESSION_TYPE') ~= 'tty' and ${if config.customVars.fonts.nerdFont then
						"true" else "false"
					}
				'';
			in with pkgs.vimPlugins; lib.mkMerge [
				[
					{
						plugin = lightline-vim;

						config = ''
							lua <<EOF
								local fn = vim.fn
								local g = vim.g
								local api = vim.api
								local mkAugroup = api.nvim_create_augroup
								local mkAutocmd = api.nvim_create_autocmd
								local lightlineAugroup = mkAugroup('lightlineAugroup', {})
								local diagnostic = vim.diagnostic
								${nerdFontLuaVar}

								function statusFn(diagnosticVar, severity)
									return function()
										local t = fn.sign_getdefined(diagnosticVar)[1]

										if not t then
											return ${"''"}
										end

										local s = t.text
										local getD = diagnostic.get
										local n = #(getD(0, {
											severity = severity,
										}))

										if n == 0 then
											return ${"''"}
										end

										return string.format('%s%d', s, n)
									end
								end

								local function lightlineSettings()
									local severity = diagnostic.severity

									if not fn.exists('g:loaded_lightline') then
										return
									end

									g.lspStatusline = {
										error = statusFn('DiagnosticSignError', severity.ERROR),
										warn = statusFn('DiagnosticSignWarn', severity.WARN),
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
											left = nerdFont and '' or ' ',
											right = nerdFont and '' or ' ',
										},

										subseparator = {
											left = nerdFont and '' or '|',
											right = nerdFont and '' or '|',
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

										inactive = {
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

									if g.customLightline and type(g.customLightline) == "function" then
										g.customLightline()
									end

									fn['lightline#update']()
								end

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
										vim.fn['lightline#update']()
									end,

									group = lightlineAugroup,
								})
EOF
						'';
					}

					{
						plugin = nvim-lspconfig;

						config = let
							setup = ls:
								''
									require('lspconfig')['${ls}'].setup(package.loaded['cmp_nvim_lsp'] and {
										capabilities = require('cmp_nvim_lsp').default_capabilities(),
									} or {})
								'';
						in ''
							lua <<EOF
								local set = vim.keymap.set
								local api = vim.api
								local diagnostic = vim.diagnostic
								local o = vim.o
								local mkAutocmd = api.nvim_create_autocmd
								local mkAugroup = api.nvim_create_augroup
								${nerdFontLuaVar}

								${lib.optionalString lspServers.nix (setup "nil_ls")}
								${lib.optionalString lspServers.go (setup "gopls")}
								${lib.optionalString lspServers.sh (setup "bashls")}
								${lib.optionalString lspServers.lua (setup "lua_ls")}
								${lib.optionalString lspServers.latex (setup "ltex")}

								local signs = {
									Error = nerdFont and ' ' or '! ',
									Warn = nerdFont and ' ' or '? ',
									Hint = nerdFont and ' ' or '* ',
									Info = nerdFont and ' ' or 'i ',
								}

								for type, icon in pairs(signs) do
									local hl = "DiagnosticSign" .. type
									vim.fn.sign_define(hl, {
										text = icon,
										texthl = hl,
										numhl = hl,
									})
								end

								diagnostic.config({
									virtual_text = {
										prefix = ${"''"},
										format = function(d)
											local s = diagnostic.severity
											local t = {
												[s.ERROR] = signs.Error .. '%s',
												[s.WARN] = signs.Warn .. '%s',
												[s.HINT] = signs.Hint .. '%s',
												[s.INFO] = signs.Info .. '%s',
											}

											return string.format(t[d.severity], d.message)
										end,
									},
								})

								o.updatetime = 250

								set('n', '[d', vim.diagnostic.goto_prev)
								set('n', ']d', vim.diagnostic.goto_next)

								local lspAugroup = mkAugroup('lspAugroup', {})

								local function floatDiagnostic()
									diagnostic.open_float(nil, {
										focus = false,
									})
								end

								mkAutocmd({'CursorHold', 'CursorHoldI'}, {
									callback = floatDiagnostic,
									group = LspAugroup,
								})

								local function lspSettings(ev)
									local set = vim.keymap.set

									vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

									local opts = {
										buffer = ev.buf,
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
											async = true,
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
				]

				(lib.mkIf cfg.cmp.enable (lib.mkMerge [
					[
						{
							plugin = nvim-cmp;

							config = ''
								lua <<EOF
									local cmp = require('cmp')

									cmp.setup({
										snippet = {
											expand = function(args)
												${lib.optionalString (cfg.cmp.snippet == "luasnip") "require('luasnip').lsp_expand(args.body)"}
											end,
										},

										window = {
											completion = cmp.config.window.bordered(),
											documentation = cmp.config.window.bordered(),
										},

										mapping = cmp.mapping.preset.insert({
											['<C-b>'] = cmp.mapping.scroll_docs(-4),
											['<C-f>'] = cmp.mapping.scroll_docs(4),
											['<C-Space>'] = cmp.mapping.complete(),
											['<C-e>'] = cmp.mapping.abort(),
											['<CR>'] = cmp.mapping.confirm({
												select = true,
											}),
										}),

										sources = cmp.config.sources({
											{
												name = 'nvim-lspconfig',
											},

											${lib.optionalString (cfg.cmp.snippet == "luasnip") ''
												{
													name = 'lua-snip',
												},
											''}
										}, {
											{
												name = 'buffer',
											},
										})
									})

									cmp.setup.cmdline({ '/', '?', }, {
										mapping = cmp.mapping.preset.cmdline(),
										sources = {
											{
												name = 'buffer',
											},
										},
									})

									cmp.setup.cmdline(':', {
										mapping = cmp.mapping.preset.cmdline(),
										sources = cmp.config.sources({
											{
												name = 'path',
											},
										}, {
												{
													name = 'cmdline',
												},
										}),
									})
EOF
							'';
						}

						{
							plugin = cmp-nvim-lsp;
						}

						{
							plugin = cmp-buffer;
						}

						{
							plugin = cmp-path;
						}

						{
							plugin = cmp-cmdline;
						}
					]

					(lib.mkIf (cfg.cmp.snippet == "luasnip") [
						{
							plugin = luasnip;
						}

						{
							plugin = cmp_luasnip;
						}
					])
				]))
			];

			extraPackages = with pkgs; lib.mkMerge [
				(lib.mkIf lspServers.nix [
					nil
				])

				(lib.mkIf lspServers.go [
					gopls
				])

				(lib.mkIf lspServers.sh [
					nodePackages_latest.bash-language-server
					shellcheck
				])

				(lib.mkIf lspServers.lua [
					lua-language-server
				])

				(lib.mkIf lspServers.latex [
					ltex-ls
				])
			];
		};
	};
}
