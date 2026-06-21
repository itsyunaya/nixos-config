{ pkgs, ... }: {
	services = {
		displayManager.ly.enable = true;
		gnome.gnome-keyring.enable = true;
		samba.enable = true;
		udisks2.enable = true;

		# needed for mullvad
		resolved.enable = true;

		mullvad-vpn = {
			enable = true;
			package = pkgs.mullvad-vpn;
		};

		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
			wireplumber.enable = true;
		};

		xserver = {
			xkb = {
				layout = "us";
				variant = "";
			};

			videoDrivers = [ "nvidia" ];
		};
	};
}
