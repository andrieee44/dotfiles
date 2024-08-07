{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
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

			homeConfigurations.andrieee44 = inputs.home-manager.lib.homeManagerConfiguration {
				pkgs = inputs.nixpkgs.legacyPackages."x86_64-linux";
				extraSpecialArgs = specialArgs;

				modules = [
					./users/default/home.nix
					./users/andrieee44/home.nix
					inputs.nixvim.homeManagerModules.nixvim
					inputs.nur.hmModules.nur
					inputs.stylix.homeManagerModules.stylix
				] ++ modules ./modules/home-manager ++ modules ./modules/stylix;
			};
			
			nixOnDroidConfigurations.oppoReno8Z = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
				pkgs = inputs.nixpkgs-stable.legacyPackages."aarch64-linux";
				extraSpecialArgs = specialArgs;
				modules = [ ./android/default/nix-on-droid.nix ];
			};
		};
}
