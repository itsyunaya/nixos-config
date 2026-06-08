{ lib, pkgs, ... }: {

	boot = {
		loader.grub.enable = false;
		loader.generic-extlinux-compatible.enable = true;
		kernelPatches = [
			{
				name = "disable-amdgpu";
				patch = null;
				extraStructuredConfig = {
					DRM_AMDGPU = lib.kernel.no;
					DRM_XE = lib.kernel.no;
				};
			}
		];
	};

	nix = {
		optimise.automatic = true;
		settings.trusted-public-keys = [ "builder:xCiGECTBIjYH0BqPn4ihN+e2Iqt25+prQGOt+lXXqkg=" ];
	};

	networking.hostName = "ceres";
	networking.networkmanager.enable = true;

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
		kitty.terminfo
		vim
		wget
	];

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

	# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
	system.stateVersion = "26.11"; # Did you read the comment?
}
