{ pkgs, ... }: {
	fonts = {
		packages = builtins.attrValues {
			inherit
				(pkgs)
				noto-fonts
				noto-fonts-cjk-sans
				noto-fonts-cjk-serif
				liberation_ttf
				noto-fonts-color-emoji
				twemoji-color-font
				;

			inherit (pkgs.nerd-fonts) jetbrains-mono;
		};

		fontconfig = {
			defaultFonts = {
				sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
				serif = [ "Noto Serif" "Noto Serif CJK JP" ];
				emoji = [ "Noto Color Emoji" "Twitter Color Emoji" ];
			};

			useEmbeddedBitmaps = true;
		};
	};

	time.timeZone = "Europe/Berlin";

	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
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

		inputMethod = {
			enable = true;
			type = "fcitx5";
			fcitx5.waylandFrontend = true;
			fcitx5.addons = with pkgs; [
				fcitx5-mozc
				fcitx5-gtk
			];
		};
	};
}
