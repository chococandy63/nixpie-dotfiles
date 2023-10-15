{ config, pkgs, ... }:

{

  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # paste your boot config here...
  # ntfs support
  boot.supportedFilesystems= ["ntfs"];


  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable= true;
  boot.loader.grub.devices= [ "nodev" ];
  boot.loader.grub.efiSupport= true;
  boot.loader.grub.useOSProber= true;
  boot.loader.grub.extraEntriesBeforeNixOS = true;
  boot.loader.grub.efiInstallAsRemovable= true;
  boot.loader.efi.efiSysMountPoint= "/boot";

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    hostName = "nixpie";
    networkmanager.enable = true;
  };

  # edit as per your location and timezone
  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
      LC_CTYPE="en_US.utf8"; # required by dmenu don't change this
    };
  };

  sound.enable = true;

  services = {
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
        ];
      };
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      displayManager = {
        lightdm.enable = true;
        defaultSession = "xfce+i3";
      };
    };
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  users.users.chococandy = {
    isNormalUser = true;
    description = "chococandy";
    extraGroups = [ "networkmanager" "wheel" "qemu-libvirtd" "libvirtd" ];
    packages = with pkgs; [
      firefox
    ];
  };
  
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = ["kvm-amd" ];

  environment.systemPackages = with pkgs; [
    alacritty
    dmenu
    git
    gnome.gnome-keyring
    nerdfonts
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    polkit_gnome
    pulseaudioFull
    rofi
    vim
    unrar
    unzip
    virt-manager
  ];

  programs = {
    thunar.enable = true;
    dconf.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  
  hardware = {
    bluetooth.enable = true;
  };

  # Don't touch this
  system.stateVersion = "23.05";

}
