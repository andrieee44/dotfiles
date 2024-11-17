{ pkgs, ... }:
{
  services.gpg-agent = {
    enableSshSupport = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    pinentryPackage = pkgs.pinentry-tty;
    extraConfig = "allow-preset-passphrase";
  };
}
