{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "ac7f7b710d2f62a9bc62c5b533847a6487e00b85";
        hash = "sha256-zVjoj828FiEAy8JlzdVuEUeujy7OFv/MuJMqacv+0ys=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-5Vg7zM6E12G6mvf9uc3PXZsUbxCjH1z9mt37CD5ALak=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;
    };
}
