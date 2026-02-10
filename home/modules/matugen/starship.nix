{ colors, createIfMissing, configHome, ... }:
{
  configFile = {
    "matugen/templates/starship.toml".text = ''
      format = "$directory$git_branch$git_status$cmd_duration$cmake$cpp$nix_shell$jobs$line_break$character"

      palette = "matugen"

      [palettes.matugen]
      primary = "{{colors.primary.default.hex}}"
      secondary = "{{colors.secondary.default.hex}}"
      tertiary = "{{colors.tertiary.default.hex}}"
      error = "{{colors.error.default.hex}}"
      surface = "{{colors.surface.default.hex}}"
      on_surface = "{{colors.on_surface.default.hex}}"
      tertiary_fixed_dim = "{{colors.tertiary_fixed_dim.default.hex}}"
      secondary_fixed_dim = "{{colors.secondary_fixed_dim.default.hex}}"

      [fill]
      symbol = " "

      [directory]
      truncation_length = 3
      truncate_to_repo = true
      style = "bold tertiary"

      [git_branch]
      style = "bold secondary"

      [git_status]
      ahead = "⇡$count"
      diverged = "⇕⇡$ahead_count⇣$behind_count"
      behind = "⇣$count"
      style = "bold error"

      [cmd_duration]
      style = "bold secondary"

      [c]
      style = "bold secondary_fixed_dim"
      format = "[$name $version ]($style)"

      [cmake]
      style = "bold secondary_fixed_dim"

      [nix_shell]
      style = "bold primary"

      [jobs]
      style = "bold error"

      [character]
      success_symbol = "[❯](bold tertiary)"
      error_symbol = "[❯](bold error)"
    '';
  };

  fallback = createIfMissing "${configHome}/starship.toml" ''
format = "$directory$git_branch$git_status$cmd_duration$cmake$cpp$nix_shell$jobs$line_break$character"

palette = "matugen"

[palettes.matugen]
primary = "#${colors.primary}"
secondary = "#${colors.secondary}"
tertiary = "#8aac8b"
error = "#${colors.error}"
surface = "#${colors.surface}"
on_surface = "#${colors.on_surface}"
tertiary_fixed_dim = "#ac8aac"
secondary_fixed_dim = "#8aacab"

[fill]
symbol = " "

[directory]
truncation_length = 3
truncate_to_repo = true
style = "bold tertiary"

[git_branch]
style = "bold secondary"

[git_status]
ahead = "⇡$count"
diverged = "⇕⇡$ahead_count⇣$behind_count"
behind = "⇣$count"
style = "bold error"

[cmd_duration]
style = "bold secondary"

[c]
style = "bold secondary_fixed_dim"
format = "[$name $version ]($style)"

[cmake]
style = "bold secondary_fixed_dim"

[nix_shell]
style = "bold primary"

[jobs]
style = "bold error"

[character]
success_symbol = "[❯](bold tertiary)"
error_symbol = "[❯](bold error)"'';
}
