{ config, lib, modulesPath, ... }: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};

		kernelModules = [ "kvm-amd" ];
		initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "sd_mod" ];
	};

	nixpkgs = {
		hostPlatform = lib.mkDefault "x86_64-linux";
	};

	networking = {
		hostName = "callisto";
		networkmanager.enable = true;

		firewall = {
			allowedTCPPorts = [ 80 443 81 ];
		};
	};

	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
