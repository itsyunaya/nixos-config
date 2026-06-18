{ pkgs, ... }: {
	systemd.services.cloudflare-ddns = {
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
}
