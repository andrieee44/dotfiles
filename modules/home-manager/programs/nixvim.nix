{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.nixvim = {
    defaultEditor = true;
    globals.mapleader = " ";

    autoCmd = [
      {
        event = [ "FileType" ];

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
          	vim.opt.colorcolumn = '72'
          	vim.opt.textwidth = 72
          	vim.opt.spell = true
          	vim.opt.spelllang = 'en'
          end
        '';
      }
    ];

    clipboard = {
      providers.wl-copy.enable = true;
      register = "unnamedplus";
    };

    keymaps = [
      {
        mode = [ "n" ];
        key = "ZW";
        action = "<cmd>w<CR>";
        options = {
          noremap = true;
        };
      }

      {
        mode = [ "n" ];
        key = "ZE";
        action = "<cmd>e<CR>";
        options = {
          noremap = true;
        };
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
      vim-be-good

      {
        plugin = nvim-terminal-lua;
        config = ''lua require('terminal').setup()'';
      }

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
          rev = "5aa3c0b608e858bf3c8636ec65f350d889128668";
          hash = "sha256-Mp4SXx6368GCExNwTWkstLv/C0wq/VhxULrG3X8v5/0=";
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
    '';

    plugins = {
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-nvim-lua.enable = true;
      cmp-nvim-ultisnips.enable = true;
      cmp-path.enable = true;
      cmp-tmux.enable = true;
      cmp-treesitter.enable = true;
      cmp-vsnip.enable = true;
      cmp-zsh.enable = true;
      cmp_luasnip.enable = true;
      cmp-buffer.enable = true;
      cmp-calc.enable = true;
      cmp-clippy.enable = true;
      cmp-cmdline.enable = true;
      lsp-format.enable = true;
      lsp-lines.enable = true;
      luasnip.enable = true;

      cmp =
        let
          plugins = config.programs.nixvim.plugins;
          source = plugin: name: lib.mkIf plugin.enable { name = name; };
        in
        {
          enable = true;
          autoEnableSources = false;

          cmdline = {
            ":" = {
              mapping.__raw = "cmp.mapping.preset.cmdline()";

              sources = [
                (source plugins.cmp-path "path")
                (source plugins.cmp-cmdline "cmdline")
              ];
            };

            "/" = {
              mapping.__raw = "cmp.mapping.preset.cmdline()";

              sources = [
                (source plugins.cmp-buffer "buffer")
                (source plugins.cmp-nvim-lsp-document-symbol "nvim_lsp_document_symbol")
              ];
            };

            "?" = {
              mapping.__raw = "cmp.mapping.preset.cmdline()";

              sources = [
                (source plugins.cmp-buffer "buffer")
                (source plugins.cmp-nvim-lsp-document-symbol "nvim_lsp_document_symbol")
              ];
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

            snippet.expand = lib.mkIf plugins.luasnip.enable ''
              function(args)
              	require('luasnip').lsp_expand(args.body)
              end
            '';

            sources = [
              (source plugins.cmp-nvim-lua "nvim_lua")
              (source plugins.cmp-nvim-lsp-signature-help "nvim_lsp_signature_help")
              (source plugins.cmp-nvim-lsp "nvim_lsp")
              (source plugins.cmp_luasnip "luasnip")
              (source plugins.cmp-path "path")
              (source plugins.cmp-buffer "buffer")
            ];
          };
        };

      lsp = {
        enable = true;
        inlayHints = true;

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
          nixd = {
            enable = true;

            settings = {
              options = {
                nixos.expr = ''import (builtins.getFlake "github:andrieee44/dotfiles").nixosConfigurations.andrieee44.options'';
                home_manager.expr = ''import (builtins.getFlake "github:andrieee44/dotfiles").homeConfigurations.andrieee44.options'';
              };

              formatting.command = [ "${pkgs.nixfmt-rfc-style}/bin/nixfmt" ];
              nixpkgs.expr = ''import (builtins.getFlake "github:andrieee44/dotfiles").inputs.nixpkgs {}'';
            };
          };

          bashls.enable = true;
          gopls.enable = true;
          ltex.enable = true;
          lua_ls.enable = true;
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

  xdg.desktopEntries =
    let
      mimeType = [
        "application/x-csh"
        "text/css"
        "text/csv"
        "text/javascript"
        "application/x-httpd-php"
        "application/rtf"
        "application/x-sh"
        "text/plain"
        "application/xml"
      ];
    in
    lib.mkIf config.programs.nixvim.enable {
      nvim = {
        name = "Neovim";
        exec = "${config.programs.nixvim.build.package}/bin/nvim %U";
        terminal = true;
        mimeType = mimeType;
      };

      nvimGUI = {
        name = "Neovim GUI";
        exec = "${config.home.sessionVariables.TERMINAL} -e ${config.programs.nixvim.build.package}/bin/nvim %U";
        mimeType = mimeType;
      };
    };
}
