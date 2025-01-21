{ config, pkgs, ... }:
{
  programs.password-store = {
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);

    settings =
      let
        dir = "${config.xdg.dataHome}/password-store";
      in
      {
        PASSWORD_STORE_DIR = dir;
        PASSWORD_STORE_GENERATED_LENGTH = "30";
        PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
        PASSWORD_STORE_EXTENSIONS_DIR = "${dir}/.extensions";
      };
  };
}
