{ inputs, pkgs, ...}:

# https://gerg-l.github.io/spicetify-nix/

let
	spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
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