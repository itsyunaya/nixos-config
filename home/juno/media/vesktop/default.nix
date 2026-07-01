{ lib, ... }: {
	xdg.configFile."vesktop/settings/quickCss.css" = lib.mkForce {
		source = ./quickCss.css;
		force = true;
	};
}
