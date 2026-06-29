{ pkgs, ... }:

{
  # Rootless container runtime for distrobox (ros2-dev Ubuntu container).
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  environment.systemPackages = with pkgs; [ distrobox ];
}
