{
	services.cloudflare-dyndns = {
		enable = true;
		domains = [ "origin.itsyunaya.app" ];
		apiTokenFile = "/var/lib/cloudflare-ddns.token";
		proxied = false;
	};
}
