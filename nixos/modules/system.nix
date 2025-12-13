{ ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;
  # Prefer prebuilt binaries from common caches to avoid local builds
  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org"
    "https://hyprland.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
  # Speed up downloads by allowing more parallel HTTP connections and failing slow mirrors faster
  nix.settings.http-connections = 50;
  nix.settings.connect-timeout = 5;
  # Use all cores for builds and allow Nix to decide per-derivation core usage
  nix.settings.max-jobs = "auto";
  nix.settings.cores = 0;

  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  
  # Disable debug symbol outputs to reduce download/build size; enable temporarily only when debugging
  environment.enableDebugInfo = false;
  systemd.coredump.enable = true;
}
