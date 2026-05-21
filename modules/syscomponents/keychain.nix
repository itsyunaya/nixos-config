{ osConfig, ... }:

{
	programs.keychain = {
		enable = true;
		enableZshIntegration = osConfig.itsyunaya-nix.shell == "zsh";
		enableNushellIntegration = osConfig.itsyunaya-nix.shell == "nushell";

		keys = [
			"id_ed25519"
		];
	};
}
