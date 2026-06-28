{
	age = {
		identityPaths = [ "/home/callisto/.ssh/id_ed25519" ];
		secrets = {
			factorio.file = ./factorio.age;
			grafana_secret = {
				file = ./grafana_secret.age;

				owner = "grafana";
				group = "grafana";
				mode = "0400";
			};
		};
	};
}
