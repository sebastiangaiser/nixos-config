{
  config,
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "editor.tabSize" = 2;
        "files.autoSave" = "onFocusChange";

        # Disable all telemetry reporting to Microsoft
        "telemetry.telemetryLevel" = "off";
        # Disable A/B experiments from Microsoft
        "workbench.enableExperiments" = false;
        # Disable online natural language settings search (sends queries to Microsoft)
        "workbench.settings.enableNaturalLanguageSearch" = false;
      };
    };
  };
}
