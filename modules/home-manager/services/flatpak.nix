{
  services.flatpak = {
    uninstallUnmanaged = true;
    update.onActivation = true;

    packages = [
      {
        flatpakref = "https://sober.vinegarhq.org/sober.flatpakref";
        sha256 = "sha256:1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
      }

      "com.valvesoftware.Steam"
      "net.pcsx2.PCSX2"
      "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08"
    ];
  };
}
