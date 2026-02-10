{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/gtk.css".text = ''
      @define-color theme_bg_color #{{colors.surface.default.hex_stripped}};
      @define-color theme_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color theme_base_color #{{colors.surface.default.hex_stripped}};
      @define-color theme_text_color #{{colors.on_surface.default.hex_stripped}};
      @define-color theme_selected_bg_color #{{colors.primary.default.hex_stripped}};
      @define-color theme_selected_fg_color #{{colors.on_primary.default.hex_stripped}};
      @define-color accent_bg_color #{{colors.primary.default.hex_stripped}};
      @define-color accent_fg_color #{{colors.on_primary.default.hex_stripped}};
      @define-color accent_color #{{colors.primary.default.hex_stripped}};
      @define-color destructive_bg_color #{{colors.error.default.hex_stripped}};
      @define-color destructive_fg_color #{{colors.on_error.default.hex_stripped}};
      @define-color destructive_color #{{colors.error.default.hex_stripped}};
      @define-color success_bg_color #{{colors.tertiary.default.hex_stripped}};
      @define-color success_fg_color #{{colors.on_tertiary.default.hex_stripped}};
      @define-color success_color #{{colors.tertiary.default.hex_stripped}};
      @define-color warning_bg_color #{{colors.secondary.default.hex_stripped}};
      @define-color warning_fg_color #{{colors.on_secondary.default.hex_stripped}};
      @define-color warning_color #{{colors.secondary.default.hex_stripped}};
      @define-color error_bg_color #{{colors.error.default.hex_stripped}};
      @define-color error_fg_color #{{colors.on_error.default.hex_stripped}};
      @define-color error_color #{{colors.error.default.hex_stripped}};
      @define-color window_bg_color #{{colors.surface.default.hex_stripped}};
      @define-color window_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color view_bg_color #{{colors.surface.default.hex_stripped}};
      @define-color view_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color headerbar_bg_color #{{colors.surface_container.default.hex_stripped}};
      @define-color headerbar_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color headerbar_backdrop_color #{{colors.surface.default.hex_stripped}};
      @define-color headerbar_shade_color rgba(0,0,0,0.07);
      @define-color card_bg_color #{{colors.surface_container.default.hex_stripped}};
      @define-color card_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color card_shade_color rgba(0,0,0,0.07);
      @define-color dialog_bg_color #{{colors.surface_container_high.default.hex_stripped}};
      @define-color dialog_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color popover_bg_color #{{colors.surface_container.default.hex_stripped}};
      @define-color popover_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color sidebar_bg_color #{{colors.surface_container.default.hex_stripped}};
      @define-color sidebar_fg_color #{{colors.on_surface.default.hex_stripped}};
      @define-color sidebar_shade_color rgba(0,0,0,0.07);
    '';
  };

  fallback =
    (createIfMissing "${configHome}/gtk-3.0/colors.css" ''
@define-color theme_bg_color #${colors.surface};
@define-color theme_fg_color #${colors.on_surface};
@define-color theme_selected_bg_color #${colors.primary};
@define-color theme_selected_fg_color #${colors.on_primary};'')
    +
    (createIfMissing "${configHome}/gtk-4.0/colors.css" ''
@define-color theme_bg_color #${colors.surface};
@define-color theme_fg_color #${colors.on_surface};
@define-color theme_selected_bg_color #${colors.primary};
@define-color theme_selected_fg_color #${colors.on_primary};'');
}
