{
	age = {
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
