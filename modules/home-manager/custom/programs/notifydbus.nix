{ pkgs, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "f9498e150296141f59e42051f7d4c53eb83ff092";
        hash = "sha256-s+1YOZ3UnXFL86/gh2dpoYNzs8OXUqiD8kjp/muxjC4=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-EyEVlO3ZZpkK+Xic6hQeS9UvjGBCUQ4VUzrvIqwtNdM=";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        # gzip -c "${src}/notifydbus.1" > "${"\${out}"}/share/man/man1/notifydbus.1.gz"
      '';
    };
}
