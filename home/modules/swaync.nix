{ config, pkgs, ... }:

{
  services.network-manager-applet.enable = true;

  services.swaync = {
    enable = true;

    settings = {
      "$schema" = "/etc/xdg/swaync/configSchema.json";
      positionX = "right";
      positionY = "top";
      cssPriority = "user";

      control-center-width = 380;
      # control-center-height = 860;
      # control-center-margin-top = 0;
      # control-center-margin-bottom = 0;
      # control-center-margin-right = 0;
      # control-center-margin-left = 0;

      notification-window-width = 400;
      notification-icon-size = 48;
      notification-body-image-height = 160;
      notification-body-image-width = 200;

      timeout = 4;
      timeout-low = 2;
      timeout-critical = 6;

      fit-to-screen = true;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = false;
      script-fail-notify = true;

      widgets = [
        "label"
        "mpris"
        "title"
        "dnd"
        "notifications"
      ];

      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = " 󰎟 ";
        };
        dnd = {
          text = "Do not disturb";
        };
        label = {
          max-lines = 1;
          text = " ";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
        volume = {
          label = "󰕾";
          show-per-app = true;
        };
      };
    };

    style = ''
      /* Import matugen-generated colors */
      @import url("file://${config.home.homeDirectory}/.config/swaync/colors.css");

      * {
        color: @foreground;
        all: unset;
        font-size: 15px;
        font-weight: 500;
        font-family: "Inter";
        transition: 200ms;
      }

      /* Avoid 'annoying' background */
      .blank-window {
        background: transparent;
      }

      /* CONTROL CENTER */
      .control-center {
        background: alpha(@background, .6);
        border: 0px solid @border;
        border-radius: 12px 0 0 0;
        box-shadow: 0 0 10px 0 rgba(0,0,0,.6);
        margin: 5px 0 0 0;
        padding: 12px;
      }

      /* Control Center Notifications */
      .control-center .notification-row .notification-background,
      .control-center .notification-row .notification-background .notification.critical {
        background-color: alpha(@surface, .6);
        border-radius: 16px;
        margin: 4px 0px;
        padding: 4px;
      }

      .control-center .notification-row .notification-background .notification.critical {
        color: @error;
      }

      .control-center .notification-row .notification-background .notification .notification-content {
        margin: 6px;
        padding: 8px 6px 2px 2px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
        background: alpha(@primary, .6);
        color: @foreground;
        border-radius: 12px;
        margin: 6px;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        background: @primary;
      }

      .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        background-color: @primary;
      }

      /* Control Center Buttons */
      .control-center .notification-row .notification-background .close-button {
        background: transparent;
        border-radius: 6px;
        color: @foreground;
        margin: 0px;
        padding: 4px;
      }

      .control-center .notification-row .notification-background .close-button:hover {
        background-color: @primary;
      }

      .control-center .notification-row .notification-background .close-button:active {
        background-color: @primary;
      }

      progressbar,
      progress,
      trough {
        border-radius: 12px;
      }

      progressbar {
        background-color: rgba(255,255,255,.1);
      }

      /* Notifications expanded-group */
      .notification-group {
        margin: 2px 8px 2px 8px;
      }

      .notification-group-headers {
        font-weight: bold;
        font-size: 1.25rem;
        color: @foreground;
        letter-spacing: 2px;
      }

      .notification-group-icon {
        color: @foreground;
      }

      .notification-group-collapse-button,
      .notification-group-close-all-button {
        background: transparent;
        color: @foreground;
        margin: 4px;
        border-radius: 6px;
        padding: 4px;
      }

      .notification-group-collapse-button:hover,
      .notification-group-close-all-button:hover {
        background: alpha(@primary, .4);
      }

      /* WIDGETS */

      /* Notification clear button */
      .widget-title {
        font-size: 1.2em;
        margin: 6px;
      }

      .widget-title button {
        background: alpha(@surface, .4);
        border-radius: 6px;
        padding: 4px 16px;
      }

      .widget-title button:hover {
        background-color: alpha(@primary, .4);
      }

      .widget-title button:active {
        background-color: @primary;
      }

      /* Do not disturb */
      .widget-dnd {
        margin: 6px;
        font-size: 1.2rem;
      }

      .widget-dnd > switch {
        background: alpha(@surface, .4);
        font-size: initial;
        border-radius: 8px;
        box-shadow: none;
        padding: 2px;
      }

      .widget-dnd > switch:hover {
        background: alpha(@primary, .4);
      }

      .widget-dnd > switch:checked {
        background: @primary;
      }

      .widget-dnd > switch:checked:hover {
        background: alpha(@primary, .4);
      }

      .widget-dnd > switch slider {
        background: @foreground;
        border-radius: 6px;
      }

      /* Music player */
      .widget-mpris {
        background: transparent;
        border-radius: 24px;
        color: @foreground;
        margin: 2px;
        padding: 6px 6px 6px 6px;
      }

      .widget-mpris-player {
        background-color: alpha(@primary, .6);
        border-radius: 20px;
        padding: 10px 10px;
        margin: 4px;
      }

      .widget-mpris > box > button {
        color: @foreground;
        border-radius: 20px;
      }

      .widget-mpris button {
        all: unset;
        background: transparent;
        border-radius: 50%;
        padding: 7px;
        color: alpha(@foreground, 0.88);
        font-size: 16px;
        min-width: 34px;
        min-height: 34px;
        transition: background-color 0.15s ease, color 0.15s ease;
      }

      .widget-mpris button:hover {
        background-color: rgba(150, 155, 165, 0.40);
        color: @foreground;
      }

      .widget-mpris button:disabled {
        color: alpha(@foreground, 0.3);
      }

      .widget-mpris-album-art {
        border-radius: 16px;
      }

      .widget-mpris-title {
        font-weight: 700;
        font-size: 1rem;
      }

      .widget-mpris-subtitle {
        font-weight: 500;
        font-size: 0.9rem;
      }

      picture.mpris-background {
        opacity: 0;
      }

      /* Volume */
      .widget-volume {
        background: @surface;
        color: @background;
        padding: 4px;
        margin: 6px;
        border-radius: 6px;
      }

      /* FLOATING NOTIFICATIONS */
      .notification-row {
        outline: none;
        margin: 0;
        padding: 0px;
      }

      .floating-notifications.background .notification-row .notification-background {
        background: alpha(@background, .55);
        box-shadow: 0 0 8px 0 rgba(0,0,0,.6);
        border-radius: 24px;
        margin: 16px;
        padding: 0;
      }

      .floating-notifications.background .notification-row .notification-background .notification {
        padding: 6px;
        border-radius: 12px;
      }

      .floating-notifications.background .notification-row .notification-background .notification.critical {
        border: 2px solid @error;
      }

      .floating-notifications.background .notification-row .notification-background .notification .notification-content {
        margin: 14px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
        min-height: 3.4em;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
        border-radius: 8px;
        background-color: alpha(@surface, .4);
        margin: 6px;
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
        background-color: alpha(@primary, .4);
      }

      .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
        background-color: @primary;
        color: @background;
      }

      .image {
        margin: 10px 20px 10px 0px;
      }

      .summary {
        font-weight: 800;
        font-size: 1rem;
      }

      .body {
        font-size: 0.8rem;
      }

      .floating-notifications.background .notification-row .notification-background .close-button {
        margin: 6px;
        padding: 2px;
        border-radius: 6px;
        background-color: transparent;
        border: 1px solid transparent;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:hover {
        background-color: @primary;
      }

      .floating-notifications.background .notification-row .notification-background .close-button:active {
        background-color: @primary;
        color: @background;
      }

      .notification.critical progress {
        background-color: @primary;
      }

      .notification.low progress,
      .notification.normal progress {
        background-color: @primary;
      }
    '';
  };
}
