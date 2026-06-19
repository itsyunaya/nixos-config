{
	services.nextcloud = {
		enable = true;
		hostName = "nxtcld.local";
		datadir = "/srv/nextcloud/";
		https = true;

		database.createLocally = true;

		config = {
			dbtype = "pgsql";

			# only relevant for initial creation
			adminpassFile = null;
			adminuser = null;
		};

		settings.trusted_domains = [ "nxtcld.local:81" "192.168.178.10:81" ];
	};
}
