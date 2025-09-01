{ ... }:

{
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    extraConfig = {
      # Keep the graph sane and consistent
      pipewire."10-lowlatency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          # start conservative; drop later if stable
          "default.clock.quantum" = 128;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 256;
        };
      };

      # Let JACK/REAPER ask for ~128/48k and keep quantum steady
      jack."10-lowlatency" = {
        "jack.properties" = {
          "node.latency" = "128/48000";
          "node.lock-quantum" = true;
        };
      };

      # OPTIONAL: stop Pulse apps from dragging the graph too low
      pipewire-pulse."10-lowlatency" = {
        context.modules = [{
          name = "libpipewire-module-protocol-pulse";
          args = {
            "pulse.min.quantum" = "128/48000";
          };
        }];
        stream.properties = {
          "node.latency" = "128/48000";
        };
      };
    };
  };

  musnix = {
    enable = true;
    rtirq.enable = true;
    rtcqs.enable = true;
  };
}
