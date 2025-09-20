{ ... }:

{
    programs.git = {
    enable = true;
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "panosdimak";
    extraConfig.credential.credentialStore = "cache";
  };
}