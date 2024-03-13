{ config, lib, modulesPath, ... }:
{
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot = {
		initrd = {
			availableKernelModules = [
				"xhci_pci"
				"vmd"
				"ahci"
				"nvme"
			];
		};

		kernelModules = [ "kvm-intel" ];
		loader.efi.efiSysMountPoint = "/boot/efi";
	};

	fileSystems = {
		"/" = {
			device = "/dev/disk/by-uuid/84d83416-2f58-4b31-82ff-2a5d65f51422";
			fsType = "ext4";
		};

		"/home" = {
			device = "/dev/disk/by-uuid/d830de4d-6ab5-4695-811c-e249e7e8c57a";
			fsType = "ext4";
		};

		"/boot/efi" = {
			device = "/dev/disk/by-uuid/D4D9-1068";
			fsType = "vfat";
		};
	};

	swapDevices = [
		{ device = "/dev/disk/by-uuid/f5884c42-e6a7-46fd-bc8d-8c3ea267d1ef"; }
	];

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
