{ lib, config, ... }:

let
  cfg = config.profiles.audio;
in {
  options.profiles.audio.lowLatency = lib.mkEnableOption "low-latency PipeWire and musnix for audio production";

  config = {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;

      extraConfig = lib.mkIf cfg.lowLatency {
        pipewire."10-lowlatency" = {
          "context.properties" = {
            "default.clock.allowed-rates" = [ 48000 ];
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 512;
            "default.clock.min-quantum" = 512;
            "default.clock.max-quantum" = 512;
          };
        };

        jack."10-lowlatency" = {
          "jack.properties" = {
            "node.latency" = "256/48000";
            "node.lock-quantum" = true;
          };
        };
      };
    };

    musnix = lib.mkIf cfg.lowLatency {
      enable = true;
      rtirq.enable = true;
      rtcqs.enable = true;
    };
  };
}
