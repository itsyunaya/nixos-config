{ inputs, lib, pkgs, self, ... }: let
	recImport = import "${self}/functions/recursiveImport.nix" { inherit lib; };
in {
	nix.settings.experimental-features = [
    	"nix-command"
    	"flakes"
    ];

    imports = [
    	(recImport "${self}/hosts/callisto/modules")
		./secrets
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

		inputs.agenix.packages.${pkgs.stdenv.hostPlatform.system}.default
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

	# state version should only be changed when it is really necessary,
	# as it can cause system breakage. for more info see
	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "26.11";
}
