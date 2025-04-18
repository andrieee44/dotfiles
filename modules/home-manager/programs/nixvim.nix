{
  config,
  pkgs,
  lib,
  host,
  user,
  ...
}:
let
  oishiline =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "oishiline";
        rev = "0482fcefbdf571da43d7d11ea605cd484e4cd347";
        hash = "sha256-7H8hba4r4cgYpL5icRh1jesOkaI0V/hczl1svzovAbE=";
      };
    in
    pkgs.vimUtils.buildVimPlugin {
      inherit src;
      name = "oishiline";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man3"
        gzip -c "${src}/oishiline.3" > "${"\${out}"}/share/man/man3/oishiline.3.gz"
      '';
    };
in
{
  home.packages = [ oishiline ];

  programs.nixvim =
    let
      mkRaw = config.lib.nixvim.mkRaw;
    in
    {
      defaultEditor = true;
      globals.mapleader = " ";

      autoCmd = [
        {
          event = [ "FileType" ];

          callback = mkRaw ''
            function()
            	vim.bo.formatoptions = vim.bo.formatoptions:gsub("[cro]", "")
            end
          '';
        }

        {
          event = [ "FileType" ];
          pattern = [ "mail" ];

          callback = mkRaw ''
            function()
            	vim.opt.colorcolumn = 72
            	vim.opt.textwidth = 72
            	vim.opt.spell = true
            	vim.opt.spelllang = "en"
            end
          '';
        }
      ];

      clipboard = {
        providers.wl-copy.enable = true;
        register = "unnamedplus";
      };

      keymaps =
        let
          Zkey = cmd: {
            mode = [ "n" ];
            key = "Z${cmd}";
            action = "<cmd>${lib.toLower cmd}<CR>";
            options.noremap = true;
          };
        in
        [
          (Zkey "W")
          (Zkey "E")
        ]
        ++ builtins.genList (
          num:
          let
            numStr = builtins.toString (num + 1);
            lastDigit = builtins.substring (builtins.stringLength numStr - 1) 1 numStr;
          in
          {
            mode = [ "n" ];
            key = "<leader>${lastDigit}";
            action = "${numStr}gt";
            options.noremap = true;
          }
        ) 10;

      opts = {
        background = "dark";
        compatible = false;
        mouse = "";
        number = true;
        relativenumber = true;
        shiftwidth = 0;
        showmode = false;
        showtabline = 2;
        signcolumn = "yes";
        smartcase = true;
        smartindent = true;
        syntax = "enable";
        tabstop = 4;
        wildmode = "longest,list,full";

        completeopt = [
          "menu"
          "menuone"
          "noselect"
        ];
      };

      extraPlugins = with pkgs.vimPlugins; [
        oishiline
        vim-be-good
        yuck-vim

        {
          plugin = nvim-terminal-lua;
          config = "lua require(\"terminal\").setup()";
        }

        {
          plugin = nvim-web-devicons;
          config = "lua require(\"nvim-web-devicons\").setup()";
        }

        {
          plugin = trim-nvim;
          config = ''lua require('trim').setup({ patterns = { [=[%s/\(\n\n\)\n\+/\1/]=] } })'';
        }
      ];

      extraConfigLua = ''
        vim.opt.termguicolors = vim.env.XDG_SESSION_TYPE ~= "tty"

        local signs = vim.opt.termguicolors:get() and {
        	Error = " ",
        	Warn = " ",
        	Hint = " ",
        	Info = " ",
        } or {
        	Error = "! ",
        	Warn = "? ",
        	Hint = "* ",
        	Info = "i ",
        }

        for k, v in pairs(signs) do
        	local name = string.format("DiagnosticSign%s", k)

        	vim.fn.sign_define(name, {
        		text = v,
        		texthl = name,
        		numhl = string.format("DiagnosticVirtualText%s", k),
        	})
        end

        vim.diagnostic.config({
        	severity_sort = true,

        	virtual_text = {
        		prefix = "",

        		format = function(diagnostic)
        			local severity = vim.diagnostic.severity

        			local severityStr = {
        				[severity.ERROR] = "Error",
        				[severity.WARN] = "Warn",
        				[severity.HINT] = "Hint",
        				[severity.INFO] = "Info",
        			}

        			local sign = vim.fn.sign_getdefined(string.format("DiagnosticSign%s", severityStr[diagnostic.severity]))

        			return string.format("%s%s", sign[1].text, diagnostic.message)
        		end,
        	},
        })
      '';

      plugins =
        let
          plugins = config.programs.nixvim.plugins;
        in
        lib.mkMerge [
          (lib.mkIf plugins.cmp.enable {
            cmp-buffer.enable = false;
            cmp-calc.enable = true;
            cmp-cmdline.enable = true;
            cmp-cmdline-history.enable = true;
            cmp-emoji.enable = true;
            cmp-fuzzy-buffer.enable = true;
            cmp-fuzzy-path.enable = true;
            cmp-git.enable = true;
            cmp-latex-symbols.enable = true;
            cmp-nvim-lsp-document-symbol.enable = true;
            cmp-nvim-lsp.enable = true;
            cmp-nvim-lsp-signature-help.enable = true;
            cmp-nvim-lua.enable = true;
            cmp-nvim-ultisnips.enable = false;
            cmp-path.enable = false;
            cmp-tmux.enable = true;
            cmp-treesitter.enable = true;
            cmp-vsnip.enable = false;
            cmp-zsh.enable = true;
            cmp_luasnip.enable = true;
            cmp_yanky.enable = false;
          })

          (lib.mkIf plugins.lsp.enable {
            lsp-format.enable = true;
            lsp-lines.enable = true;
            lsp-signature.enable = true;
          })

          {
            fzf-lua.enable = true;
            luasnip.enable = true;
            parinfer-rust.enable = true;

            cmp =
              let
                plugins = config.programs.nixvim.plugins;

                source =
                  plugin: name: opts:
                  lib.mkIf plugin.enable (lib.recursiveUpdate { inherit name; } opts);
              in
              {
                enable = true;
                autoEnableSources = false;

                filetype.gitcommit.sources = [
                  (source plugins.cmp-buffer "buffer" { })
                  (source plugins.cmp-fuzzy-buffer "fuzzy_buffer" { })
                  (source plugins.cmp-fuzzy-path "fuzzy_path" { })
                  (source plugins.cmp-git "git" { })
                ];

                cmdline = {
                  ":" = {
                    mapping = mkRaw "cmp.mapping.preset.cmdline()";

                    sources = [
                      (source plugins.cmp-cmdline-history "cmdline_history" { })
                      (source plugins.cmp-path "path" { })

                      (source plugins.cmp-cmdline "cmdline" {
                        option.ignore_cmds = [
                          "Man"
                          "!"
                        ];
                      })
                    ];
                  };

                  "/" = {
                    mapping = mkRaw "cmp.mapping.preset.cmdline()";

                    sources = [
                      (source plugins.cmp-buffer "buffer" { })
                      (source plugins.cmp-nvim-lsp-document-symbol "nvim_lsp_document_symbol" { })
                    ];
                  };

                  "?" = {
                    mapping = mkRaw "cmp.mapping.preset.cmdline()";

                    sources = [
                      (source plugins.cmp-buffer "buffer" { })
                      (source plugins.cmp-nvim-lsp-document-symbol "nvim_lsp_document_symbol" { })
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
                    	require("luasnip").lsp_expand(args.body)
                    end
                  '';

                  sources = [
                    (source plugins.cmp-buffer "buffer" { })
                    (source plugins.cmp-calc "calc" { })
                    (source plugins.cmp-emoji "emoji" { })
                    (source plugins.cmp-latex-symbols "latex_symbols" { })
                    (source plugins.cmp_luasnip "luasnip" { })
                    (source plugins.cmp-nvim-lsp "nvim_lsp" { })
                    (source plugins.cmp-nvim-lsp-signature-help "nvim_lsp_signature_help" { })
                    (source plugins.cmp-nvim-lua "nvim_lua" { })
                    (source plugins.cmp-nvim-ultisnips "ultisnips" { })
                    (source plugins.cmp-path "path" { })
                    (source plugins.cmp-tmux "tmux" { })
                    (source plugins.cmp-treesitter "treesitter" { })
                    (source plugins.cmp-vsnip "vsnip" { })
                    (source plugins.cmp-zsh "zsh" { })
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
                  "<leader>d" = "definition";
                  "<leader>D" = "type_definition";
                  "<leader>i" = "implementation";
                  "<leader>h" = "hover";
                  "<leader>R" = "references";
                  "<leader>r" = "rename";
                  "<leader>a" = "code_action";
                  "<leader>f" = "format";
                };
              };

              servers = {
                nixd = {
                  enable = true;

                  settings = {
                    options = {
                      nixos.expr = "import (builtins.getFlake \"github:andrieee44/dotfiles\").nixosConfigurations.${host}.options";
                      home_manager.expr = "import (builtins.getFlake \"github:andrieee44/dotfiles\").homeConfigurations.${user}.options";
                      nix_on_droid.expr = "import (builtins.getFlake \"github:andrieee44/dotfiles\").nixOnDroidConfigurations.nix-on-droid.options";
                    };

                    formatting.command = [
                      "${pkgs.nixfmt-rfc-style}/bin/nixfmt"
                      "-s"
                    ];

                    nixpkgs.expr = "import (builtins.getFlake \"github:andrieee44/dotfiles\").inputs.nixpkgs {}";
                  };
                };

                lua_ls = {
                  enable = true;

                  settings = {
                    runtime.version = "LuaJIT";
                    workspace.library = [ (mkRaw "vim.env.VIMRUNTIME") ];
                  };
                };

                bashls.enable = true;
                gopls.enable = true;
                jsonls.enable = true;
                ltex.enable = true;
                yamlls.enable = true;
              };
            };

            colorizer = {
              enable = true;

              settings.user_default_options = {
                AARRGGBB = true;
                RGB = true;
                RRGGBB = true;
                RRGGBBAA = true;
                css = true;
                css_fn = true;
                hsl_fn = true;
                mode = "background";
                names = true;
                rgb_fn = true;
                tailwind = "both";

                sass = {
                  enable = true;
                  parsers = [ "css" ];
                };
              };
            };

            treesitter = {
              enable = true;
              nixvimInjections = true;
            };
          }
        ];
    };

  xdg =
    let
      mimeType = [
        "application/rtf"
        "application/vnd.apple.keynote"
        "application/x-csh"
        "application/x-httpd-php"
        "application/x-sh"
        "application/x-wine-extension-ini"
        "application/xml"
        "audio/x-mod"
        "text/css"
        "text/csv"
        "text/javascript"
        "text/plain"
        "text/x-bibtex"
        "text/x-devicetree-source"
        "text/x-go"
        "text/x-lua"
        "text/x-python"
      ];
    in
    {
      desktopEntries = lib.mkIf config.programs.nixvim.enable {
        nvim = {
          inherit mimeType;
          name = "Neovim";
          exec = "${config.programs.nixvim.build.package}/bin/nvim %U";
          terminal = true;
        };

        nvimGUI = {
          inherit mimeType;
          name = "Neovim GUI";
          exec = "${pkgs.uwsm}/bin/uwsm app -- ${config.home.sessionVariables.TERMINAL} -e ${config.programs.nixvim.build.package}/bin/nvim %U";
        };
      };
    };
}
