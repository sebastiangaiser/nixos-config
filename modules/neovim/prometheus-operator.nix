{ ... }:
let
  base = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/monitoring.coreos.com";
  all = [ "*.yaml" "*.yml" ];
in
{
  programs.nixvim.plugins.lsp.servers.yamlls.settings.yaml.schemas = {
    "${base}/alertmanager_v1.json" = all;
    "${base}/alertmanagerconfig_v1alpha1.json" = all;
    "${base}/podmonitor_v1.json" = all;
    "${base}/probe_v1.json" = all;
    "${base}/prometheus_v1.json" = all;
    "${base}/prometheusagent_v1alpha1.json" = all;
    "${base}/prometheusrule_v1.json" = all;
    "${base}/scrapeconfig_v1alpha1.json" = all;
    "${base}/servicemonitor_v1.json" = all;
    "${base}/thanosruler_v1.json" = all;
  };
}
