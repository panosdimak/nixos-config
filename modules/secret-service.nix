{ ... }:

{
  # Provide a Secret Service API for apps (VS Code, gh, etc.)
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}