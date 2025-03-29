{ pkgs, ... }:
{
  custom.programs.notifydbus.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "notifydbus";
        rev = "7ffd6f4e4e4b96edcfcd097e0b72213cfb89ce77";
        hash = "sha256-cIyKm71x3en3B3gm4c9bAFZKMS1mcv02VBSISc+R+rw=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "notifydbus";
      vendorHash = "sha256-tcC3GYxxCSJ/3SZ6LbEqaKlu6Q/0ikbE+UjY6dXB+j4=";
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
