{
	description = "NixOS System Configuration Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			# IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
			# to have it up-to-date or simply don't specify the nixpkgs input
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		swww = {
			url = "github:LGFae/swww";
		};

		nvf = {
			url = "github:NotAShelf/nvf";
			# You can override the input nixpkgs to follow your system's
			# instance of nixpkgs. This is safe to do as nvf does not depend
			# on a binary cache.
			inputs.nixpkgs.follows = "nixpkgs";
		};

        # meow
        hyprland.url = "github:hyprwm/Hyprland";
        hyprlock.url = "github:hyprwm/hyprlock";
	};

	outputs = { self, nixpkgs, home-manager, zen-browser, stylix, swww, nvf, hyprland, hyprlock, ... }@inputs: 
		let
			system = "x86_64-linux";
		in {
			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			inherit system;
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
				./hardware-configuration.nix

				stylix.nixosModules.stylix

				home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;

					home-manager.users.ashley.imports = [
						nvf.homeManagerModules.default
					];
				}
			];
			};
		};
}
