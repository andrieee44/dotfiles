{
  programs.gamescope = {
    capSysNice = true;

    args = [
      "-W 1920"
      "-H 1080"
      "-r 60"
      "-h 480"
      "-F fsr"
      "--expose-wayland"
      "--mangoapp"
    ];
  };
}
