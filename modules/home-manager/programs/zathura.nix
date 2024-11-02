{
  programs.zathura = {
    options = {
      guioptions = "cshv";
      database = "sqlite";
      selection-clipboard = "clipboard";
      show-hidden = true;
    };

    mappings = {
      u = "scroll half-up";
      d = "scroll half-down";
      D = "toggle_page_mode";
      r = "reload";
      R = "rotate";
      H = "scroll full-up";
      K = "zoom in";
      J = "zoom out";
      L = "scroll full-down";
      i = "recolor";
      g = "goto top";
    };
  };
}
