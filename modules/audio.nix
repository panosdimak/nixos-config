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
          "default.clock.allowed-rates" = [ 96000 ];
          "default.clock.rate" = 96000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 256;
          "default.clock.max-quantum" = 256;
        };
      };

      jack."10-lowlatency" = {
        "jack.properties" = {
          "node.latency" = "256/96000";
          "node.lock-quantum" = true;
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
