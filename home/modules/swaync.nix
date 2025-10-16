{ ... }:

{
  services.swaync = {
    enable = true;

    style = ''
      * {
        font-size: 12.5pt;
        font-weight: bold;
      }

      .notification.low {
        border: 10px;
        border-width: 10px;
      }

      .notification.normal {
        border: 10px;
        border-width: 10px;
      }

      .notification.critical {
        border: 10px;
        border-width: 10px;
      }

      .notification-content {
        border: 10px;
        border-width: 10px;
      }

      .control-center {
        border-width: 4px;
      }

      .widget-title > button {
        border-width: 4px;
      }

      .widget-dnd > switch {
        border-width: 4px;
      }

      .widget-mpris .widget-mpris-player {
        border-width: 4px;
      }

      .widget-mpris .widget-mpris-player > box > button {
        border-width: 4px;
      }

      .widget-mpris .widget-mpris-player > box > button:hover {
        border-width: 4px;
      }
    '';
  };
}