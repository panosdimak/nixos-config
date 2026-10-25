{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Sets nvidia-drm modeset=1 and fbdev=1 itself
    modesetting.enable = true;
    # PreserveVideoMemoryAllocations for suspend; with the open modules on 595+
    # the driver uses kernel suspend notifiers instead of the nvidia-sleep units
    powerManagement.enable = true;
    # NVIDIA's recommended module for Turing and newer
    open = true;
    # Keeps the driver initialized with no clients attached, so settings like
    # the power limit below survive and CUDA doesn't pay a cold init
    nvidiaPersistenced = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  # The module only adds these when X is enabled. Loading them from
  # modules-load also makes sure the DRM device exists before the greeter starts.
  boot.kernelModules = ["nvidia" "nvidia_drm"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
