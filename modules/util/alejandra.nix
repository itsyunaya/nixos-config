{ ... }:

{
	# alejandra doesnt currently allow passing config directly to its run command,
	# so instead a global config file is used
	xdg.configFile."alejandra.toml".text = ''
		indentation = "Tabs"
	'';
}