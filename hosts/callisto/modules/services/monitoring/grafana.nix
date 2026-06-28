{ config, ... }: {
	services.grafana = {
		enable = true;
		openFirewall = true;

		settings = {
			security.secret_key = "$__file{${config.age.secrets.grafana_secret.path}}";
			analytics.reporting_enabled = false;

			server = {
				http_addr = "0.0.0.0";
				http_port = 3000;
				enforce_domain = false;
				enable_gzip = true;
				
			};
		};
	};
}
