{
	description = "ashley/itsyunaya personal nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		# https://github.com/nix-community/home-manager
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/nix-darwin/nix-darwin
		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/nixos/nixos-hardware
		nixos-hardware = {
			url = "github:NixOS/nixos-hardware";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/an-anime-team/an-anime-game-launcher
		aagl = {
			url = "github:ezKEa/aagl-gtk-on-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/itsyunaya/alejandra-opinionated
		alejandra = {
			url = "github:itsyunaya/alejandra-opinionated";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://codeberg.org/LGFae/awww
		awww = {
			url = "git+https://codeberg.org/LGFae/awww";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/denful/import-tree
		import-tree.url = "github:vic/import-tree";

		# https://github.com/hyprwm/Hyprland
		hyprland.url = "github:hyprwm/Hyprland";

		# https://github.com/mangowm/mango
		mangowm = {
			url = "github:mangowm/mango";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/niri-wm/niri
		#niri = {
		#	url = "github:sodiboo/niri-flake";
		#	inputs.nixpkgs.follows = "nixpkgs";
		#};

		# https://github.com/nix-community/nixvim
		nixvim.url = "github:nix-community/nixvim";

		# https://github.com/Gerg-L/spicetify-nix/
		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# https://github.com/itsyunaya/xwl-notifier-rs
		xwl-notifier.url = "github:itsyunaya/xwl-notifier-rs";

		# https://github.com/0xc000022070/zen-browser-flake
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ {
		self,
		nixpkgs,
		home-manager,
		nix-darwin,
		nixos-hardware,
		aagl,
		alejandra,
		mangowm,
		nixvim,
		spicetify-nix,
		xwl-notifier,
		...
	}: {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = {
				inherit inputs self;
				theme = import ./theme.nix { inherit self; };
			};

			modules = [
				./hosts/desktop/configuration.nix
				./hosts/desktop/hardware-configuration.nix
				./options.nix

				{
					nixpkgs.overlays = [
						(final: prev: {
								alejandra = alejandra.packages.${prev.stdenv.hostPlatform.system}.default;
							})
						xwl-notifier.overlays.default
					];
				}

				home-manager.nixosModules.home-manager
				aagl.nixosModules.default
				mangowm.nixosModules.mango

				{
					home-manager.sharedModules = [
						spicetify-nix.homeManagerModules.spicetify
						nixvim.homeModules.nixvim
						mangowm.hmModules.mango
					];
				}
			];
		};

		darwinConfigurations.ashleys-MacBook-Pro = nix-darwin.lib.darwinSystem {
			system = "aarch64-darwin";
			specialArgs = { inherit inputs self; };

			modules = [
				./hosts/macbook/configuration.nix

				{
					nixpkgs.overlays = [
						(final: prev: {
								alejandra = alejandra.packages.${prev.stdenv.hostPlatform.system}.default;
							})
					];
				}

				home-manager.darwinModules.home-manager
			];
		};

		/*
		  nixosConfiguration.callisto = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs self; };

			modules = [
				./hosts/callisto/configuration.nix
				./hosts/callisto/hardware-configuration.nix
			];
		};
		*/

		nixosConfigurations.ceres = nixpkgs.lib.nixosSystem {
			system = "aarch64-linux";
			specialArgs = { inherit inputs self; };

			#pkgs = import nixpkgs {
			#	localSystem = "x86_64-linux";
			#	crossSystem = "aarch64-linux";
			#};

			modules = [
				./hosts/ceres/configuration.nix
				./hosts/ceres/hardware-configuration.nix

				nixos-hardware.nixosModules.raspberry-pi-4
			];
		};
	};
}
