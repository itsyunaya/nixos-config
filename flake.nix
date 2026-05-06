{
	description = "ashley/itsyunaya personal nixos config flake";

	inputs = {
    	nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#niri = {
		#	url = "github:sodiboo/niri-flake";
		#	inputs.nixpkgs.follows = "nixpkgs";
		#};

		# https://codeberg.org/LGFae/awww
        awww.url = "git+https://codeberg.org/LGFae/awww";

        # https://github.com/denful/import-tree
        import-tree.url = "github:vic/import-tree";

        # https://github.com/hyprwm/Hyprland
        hyprland.url = "github:hyprwm/Hyprland";

		# https://github.com/0xc000022070/zen-browser-flake
		zen-browser.url = "github:0xc000022070/zen-browser-flake";
	};

	outputs = inputs @ { self, nixpkgs, home-manager, awww, import-tree, hyprland, zen-browser, ... }:
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
