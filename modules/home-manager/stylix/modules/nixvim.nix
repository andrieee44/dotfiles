{ config, lib, ... }:
{
  options.stylix.targets.custom.nixvim = {
    enable = lib.mkEnableOption "custom implementation of styling nixvim";

    transparentBackground = {
      lineNumbers = lib.mkEnableOption "background transparency for neovim line numbers";
      otherWindows = lib.mkEnableOption "background transparency for inactive neovim windows";
    };
  };

  config.programs.nixvim =
    let
      mkRaw = config.lib.nixvim.mkRaw;
      cfg = config.stylix.targets.custom.nixvim;
      colors = config.lib.stylix.colors.withHashtag;
    in
    lib.mkIf cfg.enable {
      highlight = {
        LineNr = lib.mkIf cfg.transparentBackground.lineNumbers {
          fg = colors.base0A;
          bg = "none";
          ctermfg = "yellow";
          ctermbg = "none";
        };

        NormalNC = lib.mkIf cfg.transparentBackground.otherWindows {
          bg = "none";
          ctermbg = "none";
        };
      };

      highlightOverride = {
        TSComment.link = "Comment";
        PmenuThumb.link = "Pmenu";

        Visual = {
          bg = colors.base03;
          ctermfg = mkRaw "0";
          ctermbg = mkRaw "7";
        };

        Pmenu = {
          bg = colors.base03;
          ctermbg = mkRaw "7";
        };

        PmenuSel = {
          fg = colors.base00;
          bg = colors.base0D;
          ctermfg = mkRaw "0";
          ctermbg = mkRaw "6";
          bold = true;
        };

        CmpItemAbbr = {
          fg = colors.base05;
          bg = colors.base03;
          ctermfg = mkRaw "7";
          ctermbg = mkRaw "8";
        };

        DiagnosticWarn = {
          fg = colors.base0A;
          ctermfg = mkRaw "3";
        };
      };

      extraConfigLua = ''
        require('oishiline').setup({
        	globalArgs = {
        		colors = {
        			black = "${colors.base00}",
        			darkred = "${colors.base08}",
        			darkgreen = "${colors.base0B}",
        			darkyellow = "${colors.base0A}",
        			darkblue = "${colors.base0D}",
        			darkmagenta = "${colors.base0E}",
        			darkcyan = "${colors.base0C}",
        			lightgray = "${colors.base05}",
        			darkgray = "${colors.base03}",
        			red = "${colors.base08}",
        			green = "${colors.base0B}",
        			yellow = "${colors.base0A}",
        			blue = "${colors.base0D}",
        			magenta = "${colors.base0E}",
        			cyan = "${colors.base0C}",
        			white = "${colors.base07}",
        		},
        	},
        })
      '';
    };
}
