{ inputs, self, ... }: let
	username = "ashley";
	tree = inputs.import-tree;
in {
	users.users.${username} = {
		home = /Users/${username};
	};

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		backupFileExtension = "bak";
	};

	home-manager.users.${username} = { pkgs, ... }: {
		imports = [
			(tree "${self}/modules/ashleys-macbook-pro")
			(tree "${self}/modules/shared")
		];

		home.packages = with pkgs; [
			alejandra
			gnupg
			localsend
			neovim
			nixd
			nodejs
			pinentry_mac
			pnpm
			ripgrep
			statix
			skimpdf
			vesktop
		];

		services.gpg-agent = {
			enable = true;
			pinentry.package = pkgs.pinentry_mac;
		};

		home = {
			inherit username;
			homeDirectory = /Users/${username};

			sessionPath = [
            	"$HOME/.cargo/bin"
            	"$HOME/.spicetify"
            ];

            stateVersion = "25.11";
		};
	};

	# "Determinate uses its own daemon to manage the Nix installation that
	# conflicts with nix-darwin’s native Nix management."
	# Unfortunately Determinate seems to be objectively better on macOS so
	# ill keep using it for now...
	nix.enable = false;

	# similar to nixos state version, do not edit without proper
	# care and so on
	system.stateVersion = 7;
}
