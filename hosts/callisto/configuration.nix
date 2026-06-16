{ config, pkgs, ... }: {
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

	nix.settings.experimental-features = [
    	"nix-command"
    	"flakes"
    ];

	networking = {
		hostName = "callisto";
		networkmanager.enable = true;

		firewall = {
			allowedTCPPorts = [ 80 443 81 ];
		};
	};

	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";

	users = {
		users = {
			callisto = {
				isNormalUser = true;
				extraGroups = [ "wheel" ];
				openssh.authorizedKeys.keys = [
					"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKAyCE8xE6Oxa/kW9BmEL8XTaQvNPNdyRXVIOKJa3pZ key"
				];
			};

			smbuser = {
				isSystemUser = true;
				group = "smbuser";
			};
		};

		groups = {
			smbuser = {};
		};
	};

	environment.systemPackages = with pkgs; [
		git
		kitty.terminfo
		vim
		wget
	];

	security = {
		sudo.extraConfig = ''
			Defaults env_reset,pwfeedback
		'';
	};

	programs = {
		gnupg.agent = {
			enable = true;
			pinentryPackage = pkgs.pinentry-tty;
		};
	};

	services = {
		nextcloud = {
			enable = true;
			hostName = "nxtcld.local";
			datadir = "/srv/nextcloud/";
			https = true;

			database.createLocally = true;
			config.dbtype = "pgsql";

			# only relevant for initial creation
			config.adminpassFile = null;
			config.adminuser = null;

			settings.trusted_domains = [ "nxtcld.local:81" "192.168.178.10:81" ];
		};

		nginx = {
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
						{ addr = "0.0.0.0"; port = 81; ssl = true; }
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

		openssh = {
			enable = true;
			settings.PasswordAuthentication = false;
		};

		samba = {
			enable = true;
			openFirewall = true;

			settings = {
				global = {
					"workgroup" = "WORKGROUP";
					"server string" = "smb_callisto";
					"netbios name" = "smb_callisto";
					"security" = "user";
					"hosts allow" = "192.168.178. 127.0.0.1 localhost";
					"hosts deny" = "0.0.0.0/0";
					"guest account" = "nobody";
					"map to guest" = "bad user";
				};

				"main" = {
					path = "/srv/data";
					browseable = "yes";
					"read only" = "no";
					"guest ok" = "no";
					"create mask" = "0644";
      				"directory mask" = "0755";
					"force user" = "smbuser";
				};
			};
		};
	};

	systemd = {
		services = {
			cloudflare-ddns = {
				description = "Update Cloudflare DNS Record";
				after = [ "network-online.target" ];
				wants = [ "network-online.target" ];

				serviceConfig = {
					Type = "oneshot";
					EnvironmentFile = "/var/lib/cloudflare-ddns.token";
				};

				script = ''
					ZONE_ID="33267cf53700a016a837d9ab75b973a9"
					RECORD_NAME="itsyunaya.app"

					WAN_IP=$(${pkgs.curl}/bin/curl -s https://api.ipify.org)
					
					RECORD_ID=$(${pkgs.curl}/bin/curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?name=$RECORD_NAME&type=A" \
						-H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
						-H "Content-Type: application/json" | ${pkgs.jq}/bin/jq -r '.result[0].id')

					if [ "$RECORD_ID" != "null" ] && [ -n "$WAN_IP" ]; then
						${pkgs.curl}/bin/curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
							-H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
							-H "Content-Type: application/json" \
							--data "{\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"content\":\"$WAN_IP\",\"ttl\":1,\"proxied\":true}" \
							| ${pkgs.jq}/bin/jq -e '.success' > /dev/null

						echo "Successfully updated $RECORD_NAME to $WAN_IP with proxy enabled."
					else
						echo "Error: Could not retrieve Record ID or public IP address."
						exit 1
					fi
				'';
			};
		};

		timers = {
			cloudflare-ddns = {
				wantedBy = [ "timers.target" ];
				timerConfig = {
					OnBootSec = "1min";
					OnUnitActiveSec = "5min";
				};
			};
		};

	};

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
	system.stateVersion = "26.11";
}
