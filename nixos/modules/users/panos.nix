{ ... }:

{
  users.users.panos = {
    isNormalUser = true;
    description = "panos";
    extraGroups = [ "networkmanager" "wheel" "audio" "input"];
  };
}
