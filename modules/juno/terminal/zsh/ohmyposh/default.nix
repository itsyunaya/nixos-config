{ osConfig, lib, ... }: let
	sh = osConfig.juno-cfg.sh;
in {
	programs.oh-my-posh = lib.mkIf (sh.zshEnableExtraCustomization) {
		enable = true;
		enableZshIntegration = true;

		settings = builtins.fromJSON (builtins.readFile ./config.json);
	};
}
