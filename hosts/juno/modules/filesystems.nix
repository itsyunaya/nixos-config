{
	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/a543f583-469d-49a8-aec6-b114be316b7f";
			fsType = "ext4";
		};

		"/boot" = {
			device = "/dev/disk/by-uuid/C6CC-5385";
			fsType = "vfat";
			options = [ "fmask=0077" "dmask=0077" ];
		};

		"/mnt/secondary" = {
			device = "/dev/disk/by-uuid/fa8cc4d8-b6c0-45c1-8d4a-5d776a176383";
			fsType = "ext4";
		};
	};
}
