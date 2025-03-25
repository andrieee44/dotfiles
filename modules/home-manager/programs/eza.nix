{
  # ls = "LC_ALL=C ${coreutils}/ls -AFhl --time=birth --time-style='+%b %e %Y (%a) %l:%M %p' --color=auto --group-directories-first";
  programs.eza = {
    colors = "auto";
    git = true;
    icons = "auto";

    extraOptions = [
      "-a"
      "-l"
      "-g"
      "-h"
      "--time-style=+%b %e %Y (%a) %l:%M %p"
      "--time=created"
      "--group-directories-first"
    ];
  };
}
