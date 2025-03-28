{ pkgs, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "f9498e150296141f59e42051f7d4c53eb83ff092";
        hash = "sha256-PIcpMjbQVebW/J6VtmN3g0lwMSP8nBgWZPzqOneaThI=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-Phh1Us+ct+tLOFIYCfJFTYxDODvOb1CqGgW6Lue9yZM=";
      sourcePath = "${src.name}/cmd/notifydbus";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/notifydbus.1" > "${"\${out}"}/share/man/man1/notifydbus.1.gz"
      '';
    };
}
