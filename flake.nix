{
  inputs = {
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";

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
    inputs@{
      home-manager,
      nix-flatpak,
      nix-on-droid,
      nixos-hardware,
      nixpkgs,
      nixvim,
      nur,
      self,
      stylix,
      systems,
      treefmt-nix,
      ...
    }:
    let
      treefmtConfig = import ./modules/treefmt/treefmt.nix;

      eachSystem =
        f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages."${system}");

      specialArgs = {
        inherit inputs;
        stateVersion = "24.05";
        host = "lenovoIdeapadSlim3";
        user = "andrieee44";
      };

      importDir =
        path:
        builtins.filter (file: nixpkgs.lib.hasSuffix ".nix" file) (
          nixpkgs.lib.filesystem.listFilesRecursive path
        );
    in
    {
      formatter = eachSystem (pkgs: treefmt-nix.lib.mkWrapper pkgs treefmtConfig);

      nixosConfigurations.lenovoIdeapadSlim3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        inherit specialArgs;

        modules =
          [
            ./hosts/default/tty.nix
            ./hosts/default/gui.nix
            ./hosts/lenovoIdeapadSlim3/configuration.nix
            stylix.nixosModules.stylix
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc-laptop
            nixos-hardware.nixosModules.common-pc-laptop-ssd
          ]
          ++ importDir ./modules/nixos
          ++ importDir ./modules/stylix;
      };

      homeConfigurations =
        let
          modules =
            [
              nixvim.homeManagerModules.nixvim
              nur.modules.homeManager.default
              stylix.homeModules.stylix
              nix-flatpak.homeManagerModules.nix-flatpak
              ./users/andrieee44/account.nix
              ./users/default/tty.nix
            ]
            ++ importDir ./modules/home-manager
            ++ importDir ./modules/stylix;
        in
        {
          andrieee44 = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            extraSpecialArgs = specialArgs;

            modules = [
              ./users/andrieee44/home.nix
              ./users/default/gui.nix
            ] ++ modules;
          };

          nix-on-droid = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."aarch64-linux";
            modules = [ ./users/nix-on-droid/home.nix ] ++ modules;

            extraSpecialArgs = specialArgs // {
              user = "nix-on-droid";
            };
          };
        };

      nixOnDroidConfigurations.nix-on-droid = nix-on-droid.lib.nixOnDroidConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-linux";
        extraSpecialArgs = specialArgs;

        modules = [
          ./hosts/nix-on-droid/nix-on-droid.nix
          ./modules/nix-on-droid/stylix.nix
        ] ++ importDir ./modules/stylix;
      };

      checks = eachSystem (pkgs: {
        formatting = (treefmt-nix.lib.evalModule pkgs treefmtConfig).config.build.check self;
      });
    };
}
