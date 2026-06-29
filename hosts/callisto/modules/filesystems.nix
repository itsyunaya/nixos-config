{
	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/1476eef4-a802-48ea-98c5-4bd9a954e592";
			fsType = "ext4";
		};
		
		"/boot" = {
			device = "/dev/disk/by-uuid/6372-EBD0";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};
	
		"/mnt/media_extern" = {
			device = "/dev/disk/by-uuid/d4d5fbbc-3748-4402-b3f5-ccf5e2b69912";
			fsType = "ext4";
		};	
	};
}
