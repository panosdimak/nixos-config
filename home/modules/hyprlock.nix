{ config, ... }:
let
	wallpaperPath = "~/Pictures/gruvbox-wallpapers/wallpapers/photography/berries.jpg";
in
{
	programs.hyprlock = {
		enable = true;
		settings = {
			general.hide_cursor = false;

			background = {
				monitor = "";
				path = wallpaperPath;
				blur_passes = 2;
			};

			animations = {
				enabled = true;
				bezier = [ "linear, 1, 1, 0, 0" ];
				animation = [
					"fadeIn, 1, 4, linear"
					"fadeOut, 1, 4, linear"
					"inputFieldDots, 1, 1, linear"
				];
			};

			"input-field" = {
				monitor = "";
				size = "20%, 5%";
				outline_thickness = 3;
				fade_on_empty = false;
				rounding = 15;
				font_family = "Sans Serif";
				placeholder_text = "Enter password...";
				fail_text = "$PAMFAIL";
				dots_spacing = 0.3;
				position = "0, -20";
				halign = "center";
				valign = "center";
			};

			label = [
				{
					monitor = "";
					text = "$TIME";
					font_size = 90;
					font_family = "Sans Serif";
					position = "0, 200";
					halign = "center";
					valign = "center";
				}
				{
					monitor = "";
					text = "cmd[update:60000] date +\"%A, %d %B %Y\"";
					font_size = 25;
					font_family = "Sans Serif";
					position = "0, 100";
					halign = "center";
					valign = "center";
				}
				{
					monitor = "";
					text = "$LAYOUT[en,gr]";
					font_size = 20;
					onclick = "hyprctl switchxkblayout all next";
					position = "250, -20";
					halign = "center";
					valign = "center";
				}
			];
		};
	};
}
