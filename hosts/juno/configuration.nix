{ theme, inputs, config, pkgs, self, lib, ... }: let
	username = "ashley";
	recImport = import "${self}/functions/recursiveImport.nix";
in {
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];

	juno-cfg = {
		/*
		CAUTION: changing this always requires a reboot, and should only be performed
		from tty. If the compositor is running while its file gets removed by home-manager,
		it might fall back to a default one which needs to be removed manually
		since hm can't overwrite it anymore at that point
		*/
		# "mango" or "hyprland"
		compositor = "hyprland";

		sh = {
			# "zsh" or "nushell"
			shell = "zsh";
			# this option enables/disables omz/omp if zsh is set as the active shell.
			# can improve init times by a good margin
			zshEnableExtraCustomization = true;
		};

		# "swaylock" or "hyprlock"
		lock-app = "hyprlock";
	};

	imports = [
		(recImport { inherit lib; } "${self}/hosts/juno/modules")
	];

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		extraSpecialArgs = { inherit inputs theme self username; };

		users.${username} = import ./home.nix;
	};

	users.users.${username} = {
		isNormalUser = true;
		description = "${username}";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = [];
		shell =
			if config.juno-cfg.sh.shell == "zsh"
			then pkgs.zsh
			else pkgs.nushell;
	};

	environment = {
		systemPackages = builtins.attrValues {
			inherit
				(pkgs)
				apfs-fuse
				cifs-utils
				wget
				whitesur-cursors
				whitesur-icon-theme
				;

			qt6-qtwayland = pkgs.qt6.qtwayland;
			qt5-qtwayland = pkgs.qt5.qtwayland;

			qtsvg6 = pkgs.kdePackages.qtsvg;
			qtsvg5 = pkgs.qt5.qtsvg;
		};

		sessionVariables = {
			QT_IM_MODULE = "fcitx";
			XMODIFIERS = "@im=fcitx";
			SDL_IM_MODULE = "fcitx";
			GLFW_IM_MODULE = "ibus";
			QT_QPA_PLATFORM = "wayland";
			NIXOS_OZONE_WL = "1";
		};

		# needed so dolphin works nicely with mime types
		# kde software is so evil sometimes :(
		etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
	};

	# state version should only be changed when it is really necessary,
	# as it can cause system breakage. for more info see
	# https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
	system.stateVersion = "25.11"; # Did you read the comment?
}
