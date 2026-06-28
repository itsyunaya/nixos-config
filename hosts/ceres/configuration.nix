{ lib, pkgs, ... }: {
	boot = {
		loader.grub.enable = false;
		loader.generic-extlinux-compatible.enable = true;
	};

	nix = {
		optimise.automatic = true;
		settings.experimental-features = [ "nix-command" "flakes" ];
	};

	networking = {
		hostName = "ceres";
		networkmanager.enable = true;
		firewall = {
			enable = true;
			allowedTCPPorts = [ 80 22 53 ];
			allowedUDPPorts = [ 80 53 ];
		};
	};

	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";

	users.users.ceres = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKAyCE8xE6Oxa/kW9BmEL8XTaQvNPNdyRXVIOKJa3pZ ceres key"
		];
	};

	environment.systemPackages = with pkgs; [
		git
		kitty.terminfo
		vim
		wget
	];

	programs.gnupg.agent = {
		enable = true;
		pinentryPackage = pkgs.pinentry-tty;
	};

	security.sudo.extraConfig = ''
    	Defaults env_reset,pwfeedback
	'';

	services = {
		openssh = {
			enable = true;
			settings.PasswordAuthentication = false;
		};

		pihole-ftl = {
			enable = true;

			settings = {
				dns.upstreams = [ "9.9.9.9" "1.1.1.1" ];
			};

			lists = [
				{
					url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/refs/heads/main/lists/all_domains.txt";
					type = "block";
					enabled = true;
					description = "Pi-hole Optimized Blocklists";
				}
			];
		};

		pihole-web = {
			enable = true;
			ports = [ "80" ];
		};
	};

	# state version should only be changed when it is really necessary,
	# as it can cause system breakage. for more info see
	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "26.11"; # Did you read the comment?
}
