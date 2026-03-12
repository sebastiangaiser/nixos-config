{ ... }:
{
  programs.nixvim = {
    # ── Schema auto-detection ─────────────────────────────────────────────
    plugins.schemastore = {
      enable = true;
      yaml.enable = true;
      json.enable = true;
    };

    # ── Kubernetes schema for all YAML files ──────────────────────────────
    plugins.lsp.servers.yamlls.settings.yaml = {
      validate = true;
      completion = true;
      hover = true;
      schemas.kubernetes = [ "*.yaml" "*.yml" ];
    };
  };
}
