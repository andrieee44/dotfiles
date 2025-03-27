{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "72aae2d5ef28592f71fb9b1ac8f8d3d2e499bd7e";
        hash = "sha256-bpfxwgSa+ax9NIXmmqPWDEQsaFimBL2rmYCg8zcxpAY=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "jstat";
      vendorHash = "sha256-qjtTXHW4PIWUGWF1a8qZm8Uiwhw2Q577CsBe8p63L8k=";
      sourcePath = "${src.name}/cmd/jstat";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/jstat.1" > "${"\${out}"}/share/man/man1/jstat.1.gz"
      '';
    };
}
