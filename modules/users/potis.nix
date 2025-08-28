{ ... }:

{
  users.users.potis = {
    isNormalUser = true;
    description = "potis";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
