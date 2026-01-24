{ ... }:
{
	programs.swaylock = {
		enable = true;
	};

    xdg.configFile."swaylock/config".text =
        let
            src = "../wallpapers/clouds.jpg";
        in
        ''
            image=${src}
        ''
    + builtins.readFile ./swaylock;
}
