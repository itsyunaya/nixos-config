{ osConfig, ... }:

{
	programs.nushell = {
		enable = osConfig.itsyunaya-nix.shell == "nushell";

		shellAliases = {
			explode = "poweroff";
			nr = "sudo nixos-rebuild switch --flake /home/ashley/sysflake#nixos";
        };

		extraConfig = builtins.readFile ./config.nu;
	};
}