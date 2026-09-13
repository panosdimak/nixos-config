{...}: {
  # Steam exports MANGOHUD=1 for every game it launches (see the
  # programs.steam override in the host config), so the Vulkan layer is
  # always loaded. no_display keeps it invisible until Shift_R+F12.
  programs.mangohud = {
    enable = true;

    settings = {
      no_display = true;

      fps = true;
      frametime = true;
      frame_timing = true;
      fps_metrics = ["avg" "0.01"];

      gpu_stats = true;
      gpu_temp = true;
      gpu_power = true;
      gpu_load_change = true;

      cpu_stats = true;
      cpu_temp = true;
      cpu_power = true;
      cpu_load_change = true;

      vram = true;
      ram = true;

      gpu_name = true;
      vulkan_driver = true;
      engine_version = true;

      position = "top-left";
      font_size = 20;
      background_alpha = 0.4;
      table_columns = 3;
    };
  };
}
