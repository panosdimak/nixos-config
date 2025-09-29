{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$cmd_duration$fill$cmake$cpp$nix_shell$jobs$line_break$character";

      fill.symbol = "-";

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
