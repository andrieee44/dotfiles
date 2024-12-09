{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { systems, ... }@inputs:
    let
      eachSystem =
        f: inputs.nixpkgs.lib.genAttrs (import systems) (system: f inputs.nixpkgs.legacyPackages.${system});
      treefmtConfig = import ./modules/treefmt/treefmt.nix;

      specialArgs = {
        inputs = inputs;
        stateVersion = "24.05";
        host = "lenovoIdeapadSlim3";
        user = "andrieee44";
      };

      importDir =
        path:
        builtins.filter (file: inputs.nixpkgs.lib.hasSuffix ".nix" file) (
          inputs.nixpkgs.lib.filesystem.listFilesRecursive path
        );

    in
    {
      nixosConfigurations.lenovoIdeapadSlim3 = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs;

        modules =
          [
            ./hosts/default/configuration.nix
            ./hosts/lenovoIdeapadSlim3/configuration.nix
            inputs.stylix.nixosModules.stylix
          ]
          ++ importDir ./modules/nixos
          ++ importDir ./modules/stylix;
      };

      homeConfigurations =
        let
          modules =
            [
              inputs.nixvim.homeManagerModules.nixvim
              inputs.nur.modules.homeManager.default
              inputs.stylix.homeManagerModules.stylix
            ]
            ++ importDir ./modules/home-manager
            ++ importDir ./modules/stylix;
        in
        {
          andrieee44 = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
            extraSpecialArgs = specialArgs;

            modules = [
              ./users/andrieee44/home.nix
              ./users/andrieee44/account.nix
              ./users/default/gui.nix
              ./users/default/tty.nix
            ] ++ modules;
          };

          nix-on-droid = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";

            extraSpecialArgs = specialArgs // {
              user = "nix-on-droid";
            };

            modules = [
              ./users/nix-on-droid/home.nix
              ./users/andrieee44/account.nix
              ./users/default/tty.nix
            ] ++ modules;
          };
        };

      nixOnDroidConfigurations.nix-on-droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";
        extraSpecialArgs = specialArgs;

        modules = [
          ./hosts/nix-on-droid/nix-on-droid.nix
          ./modules/nix-on-droid/stylix.nix
        ] ++ importDir ./modules/stylix;
      };

      checks = eachSystem (pkgs: {
        formatting = (inputs.treefmt-nix.lib.evalModule pkgs treefmtConfig).config.build.check inputs.self;
      });

      formatter = eachSystem (pkgs: inputs.treefmt-nix.lib.mkWrapper pkgs treefmtConfig);
    };
}
