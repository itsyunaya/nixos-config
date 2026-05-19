{ osConfig, lib, ... }:

{
	programs.oh-my-posh =
		lib.mkMerge [
			{
				settings = builtins.fromJSON (builtins.readFile ./config.json);
			}
			(lib.mkIf (osConfig.itsyunaya-nix.shell == "zsh") {
					enable = true;
					enableZshIntegration = true;
			})
		];
}
