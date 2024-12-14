{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "69cff12c791c81b69c2036d5b3aec44c5acddd35";
        hash = "sha256-EvNd+pcsQMdb/GiRa0rnEi+OVjKRjYgxm8n3iDQdVlo=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-H1bC3sJfUxL7wVVh5mjASHDkcV2dGsdui8NuEhgvNSc=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;
    };
}
