{ pkgs, ... }:
{
  custom.programs.pwmon.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "pwmon";
        rev = "16e1071fb8d68d90c260994db3fb6a63d7c9fb01";
        hash = "sha256-YFo4nFS+iDqPPB1sa4JOBsZMxmOqni5pCShkW5Vd3oY=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "pwmon";
      vendorHash = null;
      sourcePath = "${src.name}/cmd/notifydbus";

      buildInputs = with pkgs; [
        pipewire
        wireplumber
      ];

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/pwmon.1" > "${"\${out}"}/share/man/man1/pwmon.1.gz"
      '';
    };
}
