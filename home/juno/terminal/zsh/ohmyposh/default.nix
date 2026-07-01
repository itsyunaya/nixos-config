{ osConfig, lib, ... }: {
	programs.oh-my-posh = lib.mkIf osConfig.juno-cfg.sh.zshEnableExtraCustomization {
		enable = true;
		enableZshIntegration = true;

		settings = builtins.fromJSON (builtins.readFile ./config.json);
	};
}
