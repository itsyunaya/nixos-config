{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs; # OoOoOo not purely declarative, scawy

    profiles.default.extensions = with pkgs.vscode-extensions; [
      mvllow.rose-pine
      jnoortheen.nix-ide
    ];

    profiles.default.userSettings = {
      "workbench.colorTheme" = "Rosé Pine";
      "editor.tabSize" = 4;
    };
  };
}
