{ osConfig, lib, theme, ... }: {
	config = lib.mkIf (osConfig.juno-cfg.lock-app == "swaylock") {
		programs.swaylock = {
			enable = true;
		};

		xdg.configFile."swaylock/config".text = ''
      		image=${theme.wallpaper}
    	'';
	};
}
