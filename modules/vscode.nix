{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    #profiles.default = {
    #  userSettings = {
    #    "editor.tabSize" = 2;
    #    "files.autoSave" = "onFocusChange";
    #  };
    #};
  };
}
