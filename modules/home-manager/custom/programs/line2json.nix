{ pkgs, ... }:
{
  custom.programs.line2json.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "line2json";
        rev = "c71b80f353bfc7197205f08d2c3532f0c71979b0";
        hash = "sha256-RoOAxIA647j3HUwaRc5aiaFWaafrBqDTbTNoDmZsVqg=";
      };
    in
    pkgs.buildGoModule {
      name = "line2json";
      vendorHash = null;
      src = src;

      postInstall = ''
        mkdir -p $out/share/man/man1
        gzip -c ${src}/line2json.1 > $out/share/man/man1/line2json.1.gz
      '';
    };
}
