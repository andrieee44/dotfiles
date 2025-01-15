{ pkgs, ... }:
{
  custom.programs.jstat.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "jstat";
        rev = "fc3d301f672d0ca5524905ca22244e6b0813986f";
        hash = "sha256-m9fXlaKeEIhpgj2drILvN1Wc2pFSrCrp2pzyY4u6Wck=";
      };
    in
    pkgs.buildGoModule {
      name = "jstat";
      vendorHash = "sha256-5Vg7zM6E12G6mvf9uc3PXZsUbxCjH1z9mt37CD5ALak=";
      sourcePath = "${src.name}/cmd/jstat";
      src = src;

      installPhase = ''
        	runHook preInstall
        	
        	mkdir -p $out/share/man/man1
        	gzip -c ${src}/jstat.1 > $out/share/man/man1/jstat.1.gz
        	
        	runHook postInstall
      '';
    };
}
