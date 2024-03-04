{ config, pkgs, lib, ... }:
{
	options.customVars.programs.neovim = let
		mkEnableOption = config.customVars.mkOption lib.types.bool;
	in {
		diagnosticIconsLuaTable = config.customVars.mkOption lib.types.lines;

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
		nerdFontLuaVar = config.customVars.fonts.nerdFontLuaVar;
	in {
		customVars.programs.neovim = {
			diagnosticIconsLuaTable = ''
				{
					Error = ${nerdFontLuaVar} and ' ' or '! ',
					Warn = ${nerdFontLuaVar} and ' ' or '? ',
					Hint = ${nerdFontLuaVar} and ' ' or '* ',
					Info = ${nerdFontLuaVar} and ' ' or 'i ',
				}
			'';

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
			plugins = with pkgs.vimPlugins; lib.mkMerge [
				[
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
								local nerdFont = ${nerdFontLuaVar}
								local signs = ${cfg.diagnosticIconsLuaTable}

								${lib.optionalString lspServers.nix (setup "nil_ls")}
								${lib.optionalString lspServers.go (setup "gopls")}
								${lib.optionalString lspServers.sh (setup "bashls")}
								${lib.optionalString lspServers.lua (setup "lua_ls")}
								${lib.optionalString lspServers.latex (setup "ltex")}

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

								mkAutocmd({ 'CursorHold', 'CursorHoldI' }, {
									callback = function()
										diagnostic.open_float(nil, {
											focus = false,
										})
									end,

									group = lspAugroup,
								})

								mkAutocmd('LspAttach', {
									callback = function(ev)
										local opts = {
											buffer = ev.buf,
										}

										vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

										set('n', '<Leader>d', vim.lsp.buf.definition, opts)
										set('n', '<Leader>D', vim.lsp.buf.type_definition, opts)
										set('n', '<Leader>i', vim.lsp.buf.implementation, opts)
										set('n', '<Leader>h', vim.lsp.buf.hover, opts)
										set('n', '<Leader>f', vim.lsp.buf.references, opts)
										set('n', '<Leader>r', vim.lsp.buf.rename, opts)
										set({ 'n', 'v' }, '<Leader>a', vim.lsp.buf.code_action, opts)

										set('n', '<Leader>f', function()
											vim.lsp.buf.format({
												async = true,
											})
										end, opts)
									end,

									group = lspAugroup,
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
											['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
											['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
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
EOF
							'';
						}

						{
							plugin = cmp-cmdline;
							config = builtins.readFile ./cmp-cmdline.vim;
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
