{ config, pkgs, nixpkgs-unstable, ... }:
{
  programs.vscode = {
    enable = true;
    #package = pkgs-unstable.vscode;
    #profiles.default = {
    #  userSettings = {
    #    "editor.tabSize" = 2;
    #    "files.autoSave" = "onFocusChange";
    #  };
    #};
  };
}
