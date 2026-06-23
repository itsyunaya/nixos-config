{
	services.grafana = {
		enable = true;
		openFirewall = true;

		settings = {
			# TODO: agenix
			security.secret_key = "8eb1f7f00915b5b62f41dd5e23e412cdc0d6902887b3b73dd5fbc0e0951515bd";
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
