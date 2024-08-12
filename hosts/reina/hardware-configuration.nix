# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d9b7b350-0a8b-482e-8991-05189de5279e";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6A8B-3D55";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/home/giu/Programming" = {
    device = "/dev/disk/by-uuid/57e86fdf-32e4-43e5-b89a-90bcba7357e3";
    fsType = "ext4";
  };

  fileSystems."/home/giu/Games" = {
    device = "/dev/disk/by-uuid/b99d161f-c7af-481c-88f6-f9c3b4aeba37";
    fsType = "ext4";
  };

  fileSystems."/home/media" = {
    device = "/dev/disk/by-uuid/0be1b2ce-8879-4303-a0bf-92a09c127fb4";
    fsType = "ext4";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/aee16918-3090-4a93-aa8b-dc8201c06902"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp9s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
