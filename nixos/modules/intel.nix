{ pkgs, ... }:

{
  # Intel CPU microcode updates
  hardware.cpu.intel.updateMicrocode = true;

  # Intel GPU power management and driver options
  boot.kernelParams = [
    "i915.enable_fbc=1"        # Enable framebuffer compression
    "i915.enable_psr=2"        # Enable Panel Self Refresh
    "i915.fastboot=1"          # Enable fastboot
  ];

  # Additional Intel graphics packages
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-vaapi-driver
    libvdpau-va-gl
  ];
}
