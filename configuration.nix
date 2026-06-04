{ theme, inputs, config, pkgs, lib, self, ... }: let
	username = "ashley";
	tree = inputs.import-tree;
	hm = config.home-manager.users.${username};
in {
	imports = [
		./hardware-configuration.nix
		./options.nix
	];

	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	itsyunaya-nix = {
		/*
		CAUTION: changing this always requires a reboot, and should only be performed
		from tty. If the compositor is running while its file gets removed by home-manager,
		it might fall back to a default one which needs to be removed manually
		since hm can't overwrite it anymore at that point
		*/
		compositor = "hyprland";

		shell = "zsh";
		lock-app = "hyprlock";
		terminal = "kitty";
	};

	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;

	home-manager.extraSpecialArgs = { inherit inputs theme self; };
	home-manager.users.${username} = { pkgs, ... }: {
		/*
		to avoid clutter in the main file all program specific configuration is
		performed in respective .nix module files.
		imports are handled with import-tree
		*/
		imports = [ (tree ./modules) ];

		home.packages = with pkgs; [
			(pkgs.texlive.combine {
					inherit
						(pkgs.texlive)
						scheme-medium
						biber
						biblatex
						biblatex-bath
						circuitikz
						csquotes
						lastpage
						mdframed
						needspace
						pgfplots
						svg
						transparent
						wrapfig
						zref
						;
				})

			alsa-utils
			anki
			aseprite
			btop
			(discord.override {
					withVencord = true;
				})
			fd
			fzf
			hyprpicker
			hyprshot
			jetbrains.clion
			jetbrains.idea
			jetbrains.webstorm
			keepassxc
			mpdas
			(pkgs.callPackage ./packages/musicpresence.nix {})
			nicotine-plus
			pavucontrol
			picard
			prismlauncher
			qbittorrent
			rmpc
			ripgrep
			steam
			telegram-desktop
			vesktop
			xlsclients
			yams
			xwl-notifier
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

		xdg.mimeApps = {
			enable = true;
			defaultApplications = {
				"x-scheme-handler/http" = "zen-beta.desktop";
				"x-scheme-handler/https" = "zen-beta.desktop";
				"x-scheme-handler/chrome" = "zen-beta.desktop";
				"text/html" = "zen-beta.desktop";
				"x-scheme-handler/discord" = "vesktop.desktop";
				"x-scheme-handler/tg" = "org.telegram.desktop.desktop";
				"inode/directory" = "thunar.desktop";

				"image/png" = "qimgv.desktop";
				"image/jpeg" = "qimgv.desktop";
				"image/gif" = "qimgv.desktop";
				"image/webp" = "qimgv.desktop";
				"image/bmp" = "qimgv.desktop";
				"image/svg+xml" = "qimgv.desktop";
			};
		};

		home.sessionVariables = {
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

		fontconfig = {
			defaultFonts = {
				sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
				serif = [ "Noto Serif" "Noto Serif CJK JP" ];
				emoji = [ "Noto Color Emoji" "Twitter Color Emoji" ];
			};

			useEmbeddedBitmaps = true;
		};
	};

	# these have to be enabled on a systemwide level
	# i forgot why, but my old config had it so im keeping it :>
	programs = {
		zsh.enable = config.itsyunaya-nix.shell == "zsh";

		appimage.enable = true;
		appimage.binfmt = true;

		hyprland.enable = true;
		#mango.enable = true;
		niri.enable = true;

		anime-game-launcher.enable = true;
	};

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

	networking.hostName = "nixos";
	networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;

	time.timeZone = "Europe/Berlin";
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

	i18n.inputMethod = {
		enable = true;
		type = "fcitx5";
		fcitx5.waylandFrontend = true;
		fcitx5.addons = with pkgs; [
			fcitx5-mozc
			fcitx5-gtk
		];
	};

	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

	users.users.${username} = {
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = [];
		shell =
			if config.itsyunaya-nix.shell == "zsh"
			then pkgs.zsh
			else pkgs.nushell;
	};

	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		alejandra
		cifs-utils
		devenv
		docker-compose
		ffmpeg
		ffmpegthumbnailer
		gcc
		glib
		gvfs
		libnotify
		mpd-mpris
		mpv
		nixd
		nodejs
		openssl
		pinentry-qt
		playerctl
		pnpm
		poppler
		qimgv
		qt6.qtwayland
		qt5.qtwayland
		rustup
		samba
		thunar
		thunar-media-tags-plugin
		thunar-shares-plugin
		tumbler
		unrar
		unzip
		vim
		wget
		wl-clipboard
		xdg-utils
		zathura

		# styling
		whitesur-cursors
		whitesur-icon-theme
		inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
	];

	environment.sessionVariables = {
		QT_IM_MODULE = "fcitx";
		XMODIFIERS = "@im=fcitx";
		SDL_IM_MODULE = "fcitx";
		GLFW_IM_MODULE = "ibus";
		QT_QPA_PLATFORM = "wayland";
		NIXOS_OZONE_WL = "1";
	};

	virtualisation.podman = {
		enable = true;
		dockerCompat = true;
	};

	services.gvfs.enable = true;
	services.samba.enable = true;
	services.tumbler.enable = true;

	# TODO: nixpkgs ships an old version, make own derivation
	services.displayManager.ly.enable = true;

	services.mullvad-vpn = {
		enable = true;
		package = pkgs.mullvad-vpn;
	};

	# needed for mullvad
	services.resolved.enable = true;

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
		pinentryPackage = pkgs.pinentry-qt;
	};

	# enable the little stars when typing my password (useful because im bad at typing :p)
	security.sudo.extraConfig = ''
    	Defaults env_reset,pwfeedback
	'';

	# needed so the screen lockers can actually validate my password
	# modular setup depending on which lock is in use
	security.pam.services =
		lib.optionalAttrs hm.programs.swaylock.enable { swaylock = {}; }
		// lib.optionalAttrs hm.programs.hyprlock.enable { hyprlock = {}; };

	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};

	hardware.nvidia = {
		modesetting.enable = true;
		open = false;
		nvidiaSettings = true;
	};

	# makes my bluetooth not explode hopefully
	hardware.firmware = [ pkgs.linux-firmware ];

	hardware.bluetooth = {
		enable = true;
		powerOnBoot = true;
		settings.General = {
			Experimental = true;
			FastConnectable = true;
		};
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.11"; # Did you read the comment?
}
