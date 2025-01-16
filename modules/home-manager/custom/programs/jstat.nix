{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "f59762ee1a5c4d17478db165dea0721f4e327186";
        hash = "sha256-Opq5SG9/ooOJtnQvz0vSKQoLQ4ru7tQN03LVhM3Dmko=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-5Vg7zM6E12G6mvf9uc3PXZsUbxCjH1z9mt37CD5ALak=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;

      postInstall = ''
        mkdir -p $out/share/man/man1
        gzip -c ${src}/jstat.1 > $out/share/man/man1/jstat.1.gz
      '';
    };
}
