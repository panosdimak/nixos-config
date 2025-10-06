{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$cmd_duration$fill$cmake$cpp$nix_shell$jobs$line_break$character";

      fill.symbol = " ";
      
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
      };

      git_status = {
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
      };
      
      c = {
        style = "";
        format = "[$name $version ]($style)";
      };

      nix_shell = {
        style = "bold blue";
        symbol = "❄️";
        format = "[$symbol (\($name\))]($style)";
      };
    };
  };
}
