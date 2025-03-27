{ pkgs, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "6d83ade3e36398b0f554f7b4e0f0afc68badce04";
        hash = "sha256-hJaETeUpwIh0TctQK0Z+jJTcM0ZmzJFrTvPc/DISbpc=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-dSEMeQ26lrPp65OuIKZep2IJcCb/ScCkWfkdIODx7bc=";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        # gzip -c "${src}/notifydbus.1" > "${"\${out}"}/share/man/man1/notifydbus.1.gz"
      '';
    };
}
