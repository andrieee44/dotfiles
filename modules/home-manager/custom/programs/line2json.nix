{ pkgs, ... }:
{
  custom.programs.line2json.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "line2json";
        rev = "36825f5c7e1027c47b8f206de8c9b5cea4829fc6";
        hash = "sha256-jZs5zYpObA5bm8t8HBbmyazlbY8Gfu4a0Nf+OJ68agE=";
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
