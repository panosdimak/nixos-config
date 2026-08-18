{config, ...}: {
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

  programs.steam.enable = true;

  programs.coolercontrol.enable = true;

  # Under a heavy load the GPU parks right on its stock 83°C thermal target, and
  # from there the driver overrides the manual fan curve and slams both fans to
  # 100% every few seconds. Raising the target and trimming the power limit keeps
  # it steady around 85°C, still well under the card's 93°C max operating temp.
  # Ordered after the display manager so the compositor is already holding the
  # GPU open — otherwise the driver can drop the settings when it has no client.
  systemd.services.nvidia-thermal-tuning = {
    description = "GPU thermal target and power limit";
    after = ["display-manager.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = let
        nvidia-smi = "${config.hardware.nvidia.package.bin}/bin/nvidia-smi";
      in [
        "${nvidia-smi} --gpu-target-temp=87"
        "${nvidia-smi} --power-limit=170"
      ];
    };
  };

  # Monthly bit-rot scrub of the btrfs data disk
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = ["/data"];
  };

  users.users.panos.extraGroups = ["i2c"];
}
