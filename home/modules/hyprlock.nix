{ ... }:

{
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				lock_cmd = "pidof hyprlock || hyprlock";
				inhibit_sleep = 3;
				before_sleep_cmd = "loginctl lock-session";
				after_sleep_cmd = "hyprctl dispatch dpms on";
				ignore_dbus_inhibit = false;
				ignore_systemd_inhibit = false;
				ignore_wayland_inhibit = false;
			};
		};
	};

	programs.hyprlock = {
		enable = true;
		settings = {
			general.hide_cursor = false;

			background = {
				monitor = "";
				path = "screenshot";  # Use current screen as background
				blur_passes = 4;
				blur_size = 8;
			};

			animations = {
				enabled = true;
				bezier = [ "linear, 1, 1, 0, 0" ];
				animation = [
					"fadeIn, 1, 3, linear"
					"fadeOut, 1, 3, linear"
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
