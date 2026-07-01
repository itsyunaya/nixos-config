# https://gerg-l.github.io/spicetify-nix/
{ inputs, lib, pkgs, ... }: let
	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
	config = lib.mkMerge [
		{
			programs.spicetify = {
				enable = true;
				enabledExtensions = with spicePkgs.extensions; [
					adblock
					shuffle
					groupSession
					volumePercentage
					aiBandBlocker
				];
			};
		}
		(lib.mkIf pkgs.stdenv.isLinux
			{
				xdg.configFile."spotify-flags.conf".text = ''
          			--enable-features=UseOzonePlatform
          			--ozone-platform=wayland
          			--enable-wayland-ime
        		'';
			})
	];
}
