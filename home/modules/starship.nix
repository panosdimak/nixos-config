{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$fill$cmake$cpp$nix_shell$jobs$cmd_duration$line_break$character";

      fill.symbol = " ";

      c = {
        style = "";
        format = "[$name $version ]($style)";
      };
    };
  };
}