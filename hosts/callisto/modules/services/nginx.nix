{ config, ... }: {
	services.nginx = {
		enable = true;
		virtualHosts = {
			"itsyunaya.app" = {
				forceSSL = true;
				root = "/var/www/itsyunaya-app";

				sslCertificate = "/var/lib/nginx/certs/cloudflare.crt";
				sslCertificateKey = "/var/lib/nginx/certs/cloudflare.key";
			};

			${config.services.nextcloud.hostName} = {
				forceSSL = true;
				listen = [
					{
						addr = "0.0.0.0";
						port = 81;
						ssl = true;
					}
				];

				sslCertificate = "/var/lib/self-signed/nxtcld/cert.pem";
				sslCertificateKey = "/var/lib/self-signed/nxtcld/key.pem";
			};
		};

		appendHttpConfig = ''
      		set_real_ip_from 103.21.244.0/22;
      		set_real_ip_from 103.22.200.0/22;
      		set_real_ip_from 103.31.4.0/22;
      		set_real_ip_from 141.101.64.0/18;
      		set_real_ip_from 162.254.204.0/22;
      		set_real_ip_from 172.64.0.0/13;
      		set_real_ip_from 173.245.48.0/20;
      		set_real_ip_from 188.114.96.0/20;
      		set_real_ip_from 190.93.240.0/20;
      		set_real_ip_from 197.234.240.0/22;
      		set_real_ip_from 198.41.128.0/17;
      		set_real_ip_from 199.27.128.0/21;

      		set_real_ip_from 2400:cb00::/32;
      		set_real_ip_from 2606:4700::/32;
      		set_real_ip_from 2803:f800::/32;
      		set_real_ip_from 2405:b500::/32;
      		set_real_ip_from 2405:8100::/32;
      		set_real_ip_from 2a06:98c0::/29;
      		set_real_ip_from 2c0f:f248::/32;

      		real_ip_header CF-Connecting-IP;
    	'';
	};
}
