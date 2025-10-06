{ ... }:

{
  programs.ghostty = { 
    enable = true;
    settings = {
      gtk-single-instance = true;
      background-opacity = 0.8;
      background-blur = true;
    };
  };
}