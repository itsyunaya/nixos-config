{
	systemd.timers.cloudflare-ddns = {
		wantedBy = [ "timers.target" ];
		timerConfig = {
			OnBootSec = "1min";
			OnUnitActiveSec = "5min";
		};
	};
}
