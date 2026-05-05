{
  description = "ashley/itsyunaya personal nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

	home-manager = {
		url = "github:nix-community/home-manager";
		inputs.nixpkgs.follows = "nixpkgs";
	};

	zen-browser = {
		url = "github:0xc000022070/zen-browser-flake";
		inputs.nixpkgs.follows = "nixpkgs";
		#home-manager.follows = "home-manager";
	};

	#niri = {
	#	url = "github:sodiboo/niri-flake";
	#	inputs.nixpkgs.follows = "nixpkgs";
	#};

	hyprland.url = "github:hyprwm/Hyprland";

	awww.url = "git+https://codeberg.org/LGFae/awww";

  };

  outputs = inputs @ { self, nixpkgs, home-manager, zen-browser, hyprland, awww, ... }:
	let
		system = "x86_64-linux";
	in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			
			inherit system;
			specialArgs = { inherit inputs; };			

			modules = [
				./configuration.nix
				./hardware-configuration.nix

				#{ nixpkgs.overlays = [ niri.overlays.niri ]; }

				home-manager.nixosModules.home-manager
				
				#niri.nixosModules.niri
			];
		};
	};
}
