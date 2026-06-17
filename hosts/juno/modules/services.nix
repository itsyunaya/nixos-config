{ pkgs, ... }: {
	services = {
		xserver = {
			xkb = {
				layout = "us";
				variant = "";
			};

			videoDrivers = [ "nvidia" ];
		};

		samba.enable = true;
		displayManager.ly.enable = true;
		gnome.gnome-keyring.enable = true;
		udisks2.enable = true;

		mullvad-vpn = {
			enable = true;
			package = pkgs.mullvad-vpn;
		};

		# needed for mullvad
		resolved.enable = true;

		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};
	};
}