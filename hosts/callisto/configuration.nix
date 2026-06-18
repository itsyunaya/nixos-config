{ lib, pkgs, self, ... }: let
	recImport = import "${self}/functions/recursiveImport.nix";
in {
	nix.settings.experimental-features = [
    	"nix-command"
    	"flakes"
    ];

    imports = [
    	(recImport { inherit lib; } "${self}/hosts/callisto/modules")
    ];

	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";

	users = {
		users = {
			callisto = {
				isNormalUser = true;
				extraGroups = [ "wheel" ];
				openssh.authorizedKeys.keys = [
					"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKAyCE8xE6Oxa/kW9BmEL8XTaQvNPNdyRXVIOKJa3pZ key"
				];
			};

			smbuser = {
				isSystemUser = true;
				group = "smbuser";
			};
		};

		groups = {
			smbuser = {};
		};
	};

	environment.systemPackages = with pkgs; [
		git
		kitty.terminfo
		vim
		wget
	];

	security = {
		sudo.extraConfig = ''
			Defaults env_reset,pwfeedback
		'';
	};

	programs = {
		gnupg.agent = {
			enable = true;
			pinentryPackage = pkgs.pinentry-tty;
		};
	};

	# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
	system.stateVersion = "26.11";
}
