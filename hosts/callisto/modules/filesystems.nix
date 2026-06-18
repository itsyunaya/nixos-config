{
	fileSystems."/" = {
		device = "/dev/disk/by-uuid/1476eef4-a802-48ea-98c5-4bd9a954e592";
		fsType = "ext4";
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/6372-EBD0";
		fsType = "vfat";
		options = [ "fmask=0077" "dmask=0077" ];
	};
}
