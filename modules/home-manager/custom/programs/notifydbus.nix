{ pkgs, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "f6b7b6e44d8393b9f422d95c136b6ba4fbad1af5";
        hash = "sha256-iiX+CjlPTn5iUohnjT8Gisu55CvwjzhKeC8a93a5FPg=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-mGTH0mze1chL18D9QliiMDhVpeaSwRBVlCmfPiAampE=";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        # gzip -c "${src}/notifydbus.1" > "${"\${out}"}/share/man/man1/notifydbus.1.gz"
      '';
    };
}
