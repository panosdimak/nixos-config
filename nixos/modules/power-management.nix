{ lib, pkgs, ... }:

{
  # Add power management tools to system packages
  environment.systemPackages = with pkgs; [
    powertop
    tlp
  ];

  # TLP for advanced power management
  services.tlp = {
    enable = true;
    settings = {
      # CPU Settings
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;  # Limit to 30% on battery
      
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;  # Disable turbo boost on battery
      
      # Intel GPU power management
      INTEL_GPU_MIN_FREQ_ON_AC = 0;
      INTEL_GPU_MIN_FREQ_ON_BAT = 0;
      INTEL_GPU_MAX_FREQ_ON_AC = 0;  # 0 = no limit
      INTEL_GPU_MAX_FREQ_ON_BAT = 800;  # Lower max frequency on battery
      INTEL_GPU_BOOST_FREQ_ON_AC = 0;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 800;
      
      # Runtime Power Management
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";
      
      # PCI Express Active State Power Management
      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersupersave";
      
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
      STOP_CHARGE_THRESH_BAT0 = 80;   # Stop charging at 80%
      
      # SATA link power management
      SATA_LINKPWR_ON_AC = "max_performance";
      SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
      
      # NVMe power management
      AHCI_RUNTIME_PM_ON_AC = "on";
      AHCI_RUNTIME_PM_ON_BAT = "auto";
    };
  };
  
  # Disable power-profiles-daemon as it conflicts with TLP
  # services.power-profiles-daemon.enable = lib.mkForce false;
  
  # Enable powertop for additional tuning
  powerManagement.powertop.enable = true;
  
  # Enable general power management
  powerManagement.enable = true;
  
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitch = "ignore";
        HandleLidSwitchExternalPower = "ignore";
        LidSwitchIgnoreInhibited = "no";
        HandlePowerKey = "suspend";
        InhibitDelayMaxSec = 10;
      };
    };
  };
}
