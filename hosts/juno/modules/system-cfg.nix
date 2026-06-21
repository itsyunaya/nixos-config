{ config, lib, pkgs, modulesPath, ... }: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		kernelPackages = pkgs.linuxPackages_latest;
		kernelModules = [ "kvm-amd" ];

		initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];

		# agony
		kernel.sysctl = { "fs.inotify.max_user_watches" = 1048576; };
	};

	nixpkgs = {
		hostPlatform = lib.mkDefault "x86_64-linux";
		config.allowUnfree = true;
	};

	networking = {
		hostName = "juno";
		wireless.enable = true;
		networkmanager.enable = true;
	};

	hardware = {
		cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

		graphics = {
			enable = true;
			enable32Bit = true;
		};

		nvidia = {
			modesetting.enable = true;
			open = false;
			nvidiaSettings = true;
		};

		# makes my bluetooth not explode hopefully
		firmware = [ pkgs.linux-firmware ];

		bluetooth = {
			enable = true;
			powerOnBoot = false;
			settings.General = {
				Experimental = true;
				FastConnectable = true;
			};
		};
	};

	security = {
		# enable the little stars when typing my password (useful because im bad at typing :p)
		sudo.extraConfig = ''
      		Defaults env_reset,pwfeedback
    	'';

		# needed so the screen lockers can actually validate my password
		# modular setup depending on which lock is in use
		pam.services = lib.mkMerge [
			{ ly.enableGnomeKeyring = true; }
			(lib.mkIf (config.juno-cfg.lock-app == "hyprlock") { hyprlock = {}; })
			(lib.mkIf (config.juno-cfg.lock-app == "swaylock") { swaylock = {}; })
		];
	};
}
