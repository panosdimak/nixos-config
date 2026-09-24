{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    # Common system profile used by all hosts
    ../../profiles/common.nix

    # Host-specific hardware/stack choices
    ../../modules/amd.nix
    ../../modules/nvidia.nix
    ../../modules/graphics-32bit.nix
    ../../modules/audio.nix
    ../../modules/radicale.nix
    ../../modules/home-assistant.nix
  ];

  system.stateVersion = "25.05";
  networking.hostName = "ryzen-desktop";

  profiles.audio.lowLatency = true;

  programs.steam = {
    enable = true;

    # Inherited by every game, so MangoHud's Vulkan layer activates without
    # per-game launch options. Opt out with DISABLE_MANGOHUD=1 %command%.
    package = pkgs.steam.override {
      extraEnv.MANGOHUD = "1";
    };
  };

  programs.coolercontrol.enable = true;

  # Stock 200 W buys ~3.5% more clock for 8.5 °C and 31 W. Ordered after the
  # display manager so a client holds the GPU open, or the driver drops it.
  systemd.services.nvidia-power-limit = {
    description = "GPU power limit";
    after = ["display-manager.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi --power-limit=170";
    };
  };

  # Monthly bit-rot scrub of the btrfs data disk
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = ["/data"];
  };

  users.users.panos.extraGroups = ["i2c"];
}
