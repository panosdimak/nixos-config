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
			general = {
				no_fade_in = false;
				grace = 0;
				disable_loading_bar = false;
			};

			background = {
				monitor = "";
				path = "$HOME/.cache/current_wallpaper";
				blur_passes = 3;
				contrast = 0.8916;
				brightness = 0.8172;
				vibrancy = 0.1696;
				vibrancy_darkness = 0.0;
			};

			# User box shape
			shape = {
				monitor = "";
				size = "300, 60";
				color = "rgba(255, 255, 255, 0.1)";
				rounding = -1;
				border_size = 0;
				border_color = "rgba(253, 198, 135, 0)";
				rotate = 0;
				xray = false;
				position = "0, -130";
				halign = "center";
				valign = "center";
			};

			"input-field" = {
				monitor = "";
				size = "300, 60";
				outline_thickness = 2;
				dots_size = 0.2;
				dots_spacing = 0.2;
				dots_center = true;
				outer_color = "rgba(0, 0, 0, 0)";
				inner_color = "rgba(255, 255, 255, 0.1)";
				font_color = "rgb(200, 200, 200)";
				fade_on_empty = false;
				font_family = "SF Pro Display Bold";
				placeholder_text = ''<i><span foreground="##ffffff99">Enter Password</span></i>'';
				hide_input = false;
				position = "0, -210";
				halign = "center";
				valign = "center";
			};

			label = [
				# Day-Month-Date
				{
					monitor = "";
					text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
					color = "rgba(216, 222, 233, 0.70)";
					font_size = 25;
					font_family = "SF Pro Display Bold";
					position = "0, 200";
					halign = "center";
					valign = "center";
				}
				# Time
				{
					monitor = "";
					text = ''cmd[update:1000] echo "<span>$(date +"%I:%M")</span>"'';
					color = "rgba(216, 222, 233, 0.70)";
					font_size = 120;
					font_family = "SF Pro Display Bold";
					position = "0, 100";
					halign = "center";
					valign = "center";
				}
				# User
				{
					monitor = "";
					text = "    $USER";
					color = "rgba(216, 222, 233, 0.70)";
					outline_thickness = 2;
					font_size = 18;
					font_family = "SF Pro Display Bold";
					position = "0, -130";
					halign = "center";
					valign = "center";
				}
				# Keyboard layout
				{
					monitor = "";
					text = "$LAYOUT[en,gr]";
					color = "rgba(216, 222, 233, 0.70)";
					font_size = 20;
					font_family = "SF Pro Display Bold";
					onclick = "hyprctl switchxkblayout all next";
					position = "250, -210";
					halign = "center";
					valign = "center";
				}
			];
		};
	};
}
