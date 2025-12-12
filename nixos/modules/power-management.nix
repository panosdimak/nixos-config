{ lib, pkgs, ... }:

{
  # Add power management tools to system packages
  environment.systemPackages = with pkgs; [
    powertop
    tlp
  ];

  services.thermald.enable = true;   # Intel CPU thermal management

  # TLP for advanced power management
  services.tlp = {
    enable = true;
    settings = {
      # CPU Settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;

      # Keep 100% to avoid slowdown
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;
      
      CPU_BOOST_ON_BAT = 1;
      
      # Runtime Power Management
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      
      # PCI Express Active State Power Management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave"; # safer than superpowersave
      
      # WiFi Power Saving
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      
      # Disable Wake-on-LAN
      WOL_DISABLE = "Y";
      
      # USB autosuspend
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_BTUSB = 1;  # Don't autosuspend Bluetooth
      
      # Battery care (for longevity)
      START_CHARGE_THRESH_BAT0 = 75;  # Start charging at 75%
      STOP_CHARGE_THRESH_BAT0 = 90;   # Stop charging at 90%
      
      # SATA link power management
      SATA_LINKPWR_ON_AC = "max_performance";
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
      
      # NVMe power management
      AHCI_RUNTIME_PM_ON_AC = "on";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
    };
  };
    
  # Disable Powertop's auto-tuning at startup (handled by TLP)
  powerManagement.powertop.enable = false;
  
  # Enable general power management
  powerManagement.enable = true;
  
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitchDocked = "ignore";
        # HandleLidSwitch = "suspend";  # Suspend when lid closes
        HandleLidSwitchExternalPower = "ignore";
        LidSwitchIgnoreInhibited = "no";
        HandlePowerKey = "suspend";
        InhibitDelayMaxSec = 10;
      };
    };
  };

  # Prevent BlueZ from powering BT automatically
  systemd.services.bluetooth.wantedBy = lib.mkForce [];
}
