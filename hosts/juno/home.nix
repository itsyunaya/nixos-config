{ inputs, self, pkgs, username, lib, ... }: let
	recImport = import "${self}/functions/recursiveImport.nix";
in {
	imports = [
		(recImport { inherit lib; } "${self}/modules/juno")
		(recImport { inherit lib; } "${self}/modules/shared")
	];

	home.packages = builtins.attrValues {
		tex-custom = pkgs.texlive.combine {
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
		};

		discord = pkgs.discord.override {
			withVencord = true;
		};

		prism = pkgs.prismlauncher.override {
			additionalLibs = [ pkgs.glfw ];
		};

		mp = pkgs.callPackage "${self}/packages/musicpresence.nix" {};
		zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;

		inherit
			(pkgs.jetbrains)
			clion
			idea
			webstorm
			;

		inherit
			(pkgs)
			alsa-utils
			anki
			aseprite
			btop
			fd
			fzf
			haskell-language-server
			hyprshot
			keepassxc
			mpdas
			nicotine-plus
			obsidian
			pavucontrol
			picard
			qbittorrent
			rmpc
			ripgrep
			telegram-desktop
			vesktop
			xlsclients
			yams
			xwl-notifier
			;
	};

	services.mpd = {
		enable = true;
		musicDirectory = "/home/${username}/Nextcloud/";

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

	dconf.settings = {
		"org/gnome/desktop/interface".color-scheme = "prefer-dark";
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

	home = {
		file."wallpapers" = {
			source = "${self}/assets/wallpapers/";
			target = "/home/${username}/.wallpapers";
		};

		pointerCursor = {
			gtk.enable = true;
			x11.enable = true;
			package = pkgs.whitesur-cursors;
			name = "WhiteSur-cursors";
			size = 24;
		};

		sessionVariables = {
			XDG_DATA_DIRS = "$HOME/.nix-profile/share:/run/current-system/sw/share:/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS";
		};

		stateVersion = "25.11";
	};
}
