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
          ctermfg = "black";
          ctermbg = "lightgray";
        };

        Pmenu = {
          bg = colors.base03;
          ctermbg = "lightgray";
        };

        CmpItemAbbr = {
          fg = colors.base05;
          bg = colors.base03;
          ctermfg = "white";
          ctermbg = "lightgray";
        };

        PmenuSel = {
          fg = colors.base00;
          bg = colors.base0D;
          ctermfg = "black";
          ctermbg = "cyan";
          bold = true;
        };
      };

      extraConfigLua = ''
        require('oishiline').setup({
        	globalArgs = {
        		colors = {
        			black = "${colors.base00}",
        			red = "${colors.base08}",
        			green = "${colors.base0B}",
        			yellow = "${colors.base0A}",
        			blue = "${colors.base0D}",
        			magenta = "${colors.base0E}",
        			cyan = "${colors.base0C}",
        			white = "${colors.base05}",
        			brightblack = "${colors.base03}",
        			brightred = "${colors.base08}",
        			brightgreen = "${colors.base0B}",
        			brightyellow = "${colors.base0A}",
        			brightblue = "${colors.base0D}",
        			brightmagenta = "${colors.base0E}",
        			brightcyan = "${colors.base0C}",
        			brightwhite = "${colors.base07}",
        		},
        	},
        })
      '';
    };
}
