{ config, lib, ... }:

{
	config = lib.mkIf (config.itsyunaya-nix.lock-app == "swaylock") {
		programs.swaylock = {
    		enable = true;
    	};

        xdg.configFile."swaylock/config".text =
            let
                src = "${toString ./.}/../../../assets/wallpapers/clouds.jpg";
            in
            ''
                image=${src}
            '';
	};
}
