{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nur.url = "github:nix-community/NUR";

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

	outputs = inputs: let
			specialArgs.stateVersion = "24.05";

			modules = path:
				builtins.filter (file:
					inputs.nixpkgs.lib.hasSuffix ".nix" file
				) (inputs.nixpkgs.lib.filesystem.listFilesRecursive path);
		in {
			nixosConfigurations.lenovoIdeapadSlim3 = inputs.nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = specialArgs;

				modules = [
					./hosts/default/configuration.nix
					./hosts/lenovoIdeapadSlim3/configuration.nix
					inputs.stylix.nixosModules.stylix
				] ++ modules ./modules/nixos ++ modules ./modules/stylix;
			};

			homeConfigurations = {
				andrieee44 = inputs.home-manager.lib.homeManagerConfiguration {
					pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
					extraSpecialArgs = specialArgs;

					modules = [
						./users/andrieee44/home.nix
						./users/default/gui.nix
						./users/default/tty.nix
						inputs.nixvim.homeManagerModules.nixvim
						inputs.nur.hmModules.nur
						inputs.stylix.homeManagerModules.stylix
					] ++ modules ./modules/home-manager ++ modules ./modules/stylix;
				};

				nix-on-droid = inputs.home-manager.lib.homeManagerConfiguration {
					pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";
					extraSpecialArgs = specialArgs;

					modules = [
						./users/nix-on-droid/home.nix
						./users/default/tty.nix
						/*
						inputs.nixvim.homeManagerModules.nixvim
						inputs.nur.hmModules.nur
						inputs.stylix.homeManagerModules.stylix
						*/
					]; # ++ modules ./modules/home-manager ++ modules ./modules/stylix;
				};
			};

			nixOnDroidConfigurations.nix-on-droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
				pkgs = inputs.nixpkgs.legacyPackages."aarch64-linux";
				extraSpecialArgs = specialArgs;
				modules = [ ./hosts/nix-on-droid/nix-on-droid.nix ];
			};
		};
}
