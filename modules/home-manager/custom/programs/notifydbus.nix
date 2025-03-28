{ pkgs, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "9a8c2dd93a7a206515419d4e3ebf6736ccb70a63";
        hash = "sha256-o/RNqiZ8lGZwuf50TpfWGhm9HmjFuEjXABhUw2WYb8c=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-Phh1Us+ct+tLOFIYCfJFTYxDODvOb1CqGgW6Lue9yZM=";
      sourcePath = "${src.name}/cmd/notifydbus";

      buildInputs = with pkgs; [
        pipewire
        wireplumber
      ];

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/notifydbus.1" > "${"\${out}"}/share/man/man1/notifydbus.1.gz"
      '';
    };
}
