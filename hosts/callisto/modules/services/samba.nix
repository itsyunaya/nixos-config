{
	services.samba = {
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
}
