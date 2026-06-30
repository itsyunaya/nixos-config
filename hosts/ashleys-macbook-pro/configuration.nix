{ inputs, lib, self, ... }: let
	username = "ashley";
	recImport = import "${self}/functions/recursiveImport.nix" { inherit lib; };
in {
	users.users.${username} = {
		home = /Users/${username};
	};

	nixpkgs.config.allowUnfree = true;

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		backupFileExtension = "bak";
		extraSpecialArgs = { inherit inputs; };
	};

	home-manager.users.${username} = { pkgs, ... }: {
		imports = [
			(recImport "${self}/modules/ashleys-macbook-pro")
			(recImport "${self}/modules/shared")
		];

		home.packages = builtins.attrValues {
			inherit
				(pkgs)
				alejandra
				gnupg
				localsend
				musicpresence
				neovim
				nixd
				nodejs-slim
				pinentry_mac
				pnpm
				ripgrep
				statix
				skimpdf
				vesktop
				;
		};

		services.gpg-agent = {
			enable = true;
			pinentry.package = pkgs.pinentry_mac;
		};

		home = {
			inherit username;
			homeDirectory = /Users/${username};

			sessionPath = [
				"$HOME/.cargo/bin"
			];

			stateVersion = "25.11";
		};
	};

	# "Determinate uses its own daemon to manage the Nix installation that
	# conflicts with nix-darwin’s native Nix management."
	# Unfortunately Determinate seems to be objectively better on macOS so
	# ill keep using it for now...
	nix.enable = false;

	# this value is similar to nixOS state version, and should be treated
	# accordingly. do not edit unless it is strictly necessary and you
	# know what you are doing
	system.stateVersion = 7;
}
