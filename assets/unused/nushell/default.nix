{ osConfig, ... }: {
	programs.nushell = {
		enable = osConfig.juno-cfg.sh.shell == "nushell";

		shellAliases = {
			explode = "poweroff";
			nr = "sudo nixos-rebuild switch --flake /home/ashley/sysflake#nixos";
		};

		extraConfig = builtins.readFile ./config.nu;
	};
}
