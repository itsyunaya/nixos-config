{ pkgs, ... }: {
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

	nix.settings.experimental-features = [
    	"nix-command"
    	"flakes"
    ];

	networking = {
		hostName = "callisto";
		networkmanager.enable = true;
	};

	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";

	users.users.callisto = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKAyCE8xE6Oxa/kW9BmEL8XTaQvNPNdyRXVIOKJa3pZ key"
		];
	};

	# REMOVE ONCE INSTALLED
	security.sudo.wheelNeedsPassword = false;

	environment.systemPackages = with pkgs; [
		git
		kitty.terminfo
		vim
		wget
	];

	services = {
		openssh.enable = true;
	};

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
	system.stateVersion = "26.11";
}
