{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nur.url = "github:nix-community/NUR";
		stylix.url = "github:danth/stylix";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixvim = {
			url = "github:nix-community/nixvim";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { ... } @ inputs: let
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
					./hosts/lenovoIdeapadSlim3/configuration.nix
					./hosts/default/configuration.nix
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
		};
}
