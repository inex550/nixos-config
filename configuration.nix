# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

rec {
  imports = [
	./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup network
  networking.hostName = "inex-nb";
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  # Setting timezone
  time.timeZone = "Europe/Moscow";

  # Normal users configuration
  users.users.inex = {
    isNormalUser = true;
    home = "/home/inex";
    description = "Primary user";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Desktop environment configuration
  programs = {
    sway = {
      enable = true;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    vim neovim
    tree file htop
    git
  ];

  # First NixOS version. DO NOT CHANGE
  system.stateVersion = "25.05";
}

