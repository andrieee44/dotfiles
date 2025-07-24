{
  services.flatpak = {
    uninstallUnmanaged = true;
    update.onActivation = true;
    packages = [ "org.vinegarhq.Sober" ];
  };
}
