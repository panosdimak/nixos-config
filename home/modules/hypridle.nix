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
			};
			listener = [
				{
					timeout = 600;
					"on-timeout" = "loginctl lock-session";
				}
			];
		};
	};
}
