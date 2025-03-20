{ config, pkgs, ... }:{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration/container.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-08fc6e5f-fa73-469c-81c5-e68d7b34cdfd".device = "/dev/disk/by-uuid/08fc6e5f-fa73-469c-81c5-e68d7b34cdfd";
  networking.hostName = "dell-xps13";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  boot.loader.systemd-boot.configurationLimit = 10;
  nix.settings.auto-optimise-store = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  services.fwupd = {
    enable = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.sebastian = {
    isNormalUser = true;
    description = "Sebastian";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
    ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    neovim
    htop
    ghostty
  ];

  environment.variables.EDITOR = "nvim";

  system.autoUpgrade = {
    enable = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "24.11";
}
