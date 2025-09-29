{ lib, ... }:
let
	wallpaperPath = "~/Pictures/Wallpapers/mountain-village.png";
in {
	services.hyprpaper = {
		enable = true;
		settings = {
			preload = [ wallpaperPath ];
			wallpaper = [ ", ${wallpaperPath}" ];
		};
	};
}
