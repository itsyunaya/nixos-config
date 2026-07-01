{ inputs, pkgs, ... }: let
	discord = pkgs.discord.override {
		withVencord = true;
	};

	prism = pkgs.prismlauncher.override {
		# system glfw for running mc natively on wayland
		# only works for some versions up to 26.x
		additionalLibs = [ pkgs.glfw ];
	};

	awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
	zen = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
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

		inherit
			discord
			prism
			awww
			zen
			;

		inherit
			(pkgs.jetbrains)
			clion
			idea
			webstorm
			;

		inherit
			(pkgs.kdePackages)
			dolphin
			kio
			kio-extras
			kio-fuse
			;

		inherit
			(pkgs)
			alejandra
			alsa-utils
			anki
			aseprite
			btop
			darkly
			ffmpeg
			ffmpegthumbnailer
			fzf
			haskell-language-server
			hyprshot
			keepassxc
			libnotify
			mpdas
			mpd-mpris
			mpv
			musicpresence
			nh
			nicotine-plus
			nil
			nodejs-slim
			obsidian
			openssl
			pavucontrol
			pinentry-qt
			picard
			playerctl
			pnpm
			qbittorrent
			qimgv
			ripgrep
			rmpc
			statix
			telegram-desktop
			unzip
			vesktop
			wl-clipboard
			xdg-utils
			xlsclients
			xwl-notifier
			yams
			zathura
			;
	};
}
