{ pkgs, ... }:
{
  services.gpg-agent = {
    defaultCacheTtl = 34560000;
    enableSshSupport = false;
    extraConfig = "allow-preset-passphrase";
    maxCacheTtl = 34560000;
    pinentry.package = pkgs.pinentry-tty;
  };
}
