{ pkgs, ... }:
{
  services.gpg-agent = {
    enableSshSupport = false;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    pinentryPackage = pkgs.pinentry-tty;
    extraConfig = "allow-preset-passphrase";
  };
}
