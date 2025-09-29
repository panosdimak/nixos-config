{ lib, ... }:
{
	programs.hyprlock = {
		enable = true;
		settings = {
			general.hide_cursor = false;

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
				font_family = "Monospace";
				placeholder_text = "Input password...";
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
					font_family = "Monospace";
					position = "-30, 0";
					halign = "right";
					valign = "top";
				}
				{
					monitor = "";
					text = "cmd[update:60000] date +\"%A, %d %B %Y\"";
					font_size = 25;
					font_family = "Monospace";
					position = "-30, -150";
					halign = "right";
					valign = "top";
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
