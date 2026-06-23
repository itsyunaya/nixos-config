{ config, ... }: {
	services.prometheus = {
		enable = true;

		exporters.node = {
			enable = true;
			enabledCollectors = [ "systemd" "processes" ];
		};

		scrapeConfigs = [
			{
				job_name = "callistoNode";
				static_configs = [{
					targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
				}];
			}
		];
	};
}
