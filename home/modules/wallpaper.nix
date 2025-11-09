{ pkgs, inputs, ... }:

let
	wallpaperPath = "~/Pictures/gruvbox-wallpapers/wallpapers/photography/berries.jpg";
in {
	services.hyprpaper = {
		enable = true;
		settings = {
			preload = [ wallpaperPath ];
			wallpaper = [ ", ${wallpaperPath}" ];
		};
	};
    home.packages = with pkgs; [
     waypaper
  ];
}
