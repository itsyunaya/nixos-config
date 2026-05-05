{ lib, ... }:

{
	xdg.configFile."rmpc/config.ron" = lib.mkForce {
		source = ./config.ron;
		force = true;
	};

	xdg.configFile."rmpc/themes/silly.ron" = lib.mkForce {
		source = ./silly.ron;
		force = true;
	};
}
