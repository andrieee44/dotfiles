{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "d72d220763b17a9b2c4d1cdc246c2aa7325acf26";
        hash = "sha256-H7Qr8O1YQuS16o2fjHrYPhT4yULT97dKrLzeyiH+Xg4=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-EyEVlO3ZZpkK+Xic6hQeS9UvjGBCUQ4VUzrvIqwtNdM=";
      sourcePath = "${src.name}/cmd/jstat";

      buildInputs = with pkgs; [
        pipewire
        wireplumber
      ];

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
