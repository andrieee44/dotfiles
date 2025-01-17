{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "7a98603d4b204bdb2a75851db06d7b994fbe6ac5";
        hash = "sha256-YJxZUUPS1f16atjRbOd+GCUwZchHXdAZK7ZSHvcJYCM=";
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
