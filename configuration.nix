# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

let
	username = "ashley";
	musicpresence = pkgs.callPackage ./modules/media/musicpresence.nix { };
in {
	imports = [
    	./hardware-configuration.nix
    ];

	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;

	home-manager.extraSpecialArgs = { inherit inputs; };
	home-manager.users.${username} = { pkgs, ... }: {
		# to avoid clutter in the main file all program specific configuration is
		# going to be performed in respective .nix files
		imports = [
			./modules/imports.nix
		];

		home.packages = with pkgs; [
			alsa-utils
			btop
			fd
			fzf
			jetbrains.webstorm
			keepassxc
			mpdas
			musicpresence
			neovim
			pavucontrol
			prismlauncher
			rmpc
			ripgrep
			steam
			vesktop
			xlsclients			
			inputs.zen-browser.packages."${stdenv.hostPlatform.system}".default
		];

		services.mpd = {
			enable = true;
			musicDirectory = "/home/${username}/Nextcloud/music";
	
			extraConfig = ''
				auto_update "yes"

				audio_output {
					type "pulse"
					name "pulseout"
				}
			'';
		};

		services.nextcloud-client = {
			enable = true;
			startInBackground = true;
		};

		gtk = {
			enable = true;
			gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
			gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
			iconTheme = {
				package = pkgs.whitesur-icon-theme;
				name = "WhiteSur-dark";
			};
		};

		qt = {
			enable = true;
			platformTheme.name = "gtk";
			style.name = "adwaita-dark";
		};

		dconf.settings = {
			"org/gnome/desktop/interface".color-scheme = "prefer-dark";	
		};

		home.pointerCursor = {
			gtk.enable = true;
			x11.enable = true;
			package = pkgs.whitesur-cursors;
			name = "WhiteSur-cursors";
			size = 24;
		};

		home.sessionVariables = {
  			ELECTRON_FORCE_IS_PACKAGED = "1";

			XDG_DATA_DIRS = "$HOME/.nix-profile/share:/run/current-system/sw/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS";
		};

		home.stateVersion = "25.11";	
	};

	fonts = {
		packages = with pkgs; [
			nerd-fonts.jetbrains-mono

			noto-fonts
			noto-fonts-cjk-sans
			noto-fonts-cjk-serif
			liberation_ttf

			noto-fonts-color-emoji
			twemoji-color-font
		];

		fontconfig.defaultFonts = {
			emoji = [
				"Twitter Color Emoji"
				"Noto Color Emoji"
			];
		};

	};

	# these have to be enabled on a systemwide level
	# i forgot why, but my old config had it so im keeping it :>
	programs = {
		zsh.enable = true;

		appimage.enable = true;
		appimage.binfmt = true;

		niri.enable = true;
	};

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.${username} = {
		isNormalUser = true;
		description = "ashley";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
		shell = pkgs.zsh;
	};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
	environment.systemPackages = with pkgs; [
		vim
		wget
		playerctl
		xdg-utils
		wl-clipboard
		gcc
		nodejs
		pnpm
		openssl
		pinentry-qt
		libnotify
		nixfmt
		unzip
		unrar
		mpd-mpris

		# styling
		whitesur-cursors
		whitesur-icon-theme
		inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  	];

	#environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
	};

	programs.gnupg.agent = {
		enable = true;
		enableSSHSupport = true;
		pinentryPackage = pkgs.pinentry-gtk2;
	};

	# enable the little stars when typing my password (useful because im bad at typing :p)
	security.sudo.extraConfig = ''
    	Defaults env_reset,pwfeedback
  	'';

	services.xserver.videoDrivers = ["nvidia"];
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

	hardware.nvidia = {
    	modesetting.enable = true;
    	open = false;
    	nvidiaSettings = true;
	};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
