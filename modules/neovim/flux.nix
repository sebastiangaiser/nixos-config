{ ... }:
{
  programs.nixvim.plugins.lsp.servers.yamlls.settings.yaml.schemas = {
    "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/crds/kustomize.toolkit.fluxcd.io_kustomizations.yaml" =
      [ "*.yaml" "*.yml" ];
    "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/crds/helm.toolkit.fluxcd.io_helmreleases.yaml" =
      [ "*.yaml" "*.yml" ];
    "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/crds/source.toolkit.fluxcd.io_helmrepositories.yaml" =
      [ "*.yaml" "*.yml" ];
    "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/crds/source.toolkit.fluxcd.io_gitrepositories.yaml" =
      [ "*.yaml" "*.yml" ];
    "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/crds/source.toolkit.fluxcd.io_ocirepositories.yaml" =
      [ "*.yaml" "*.yml" ];
    "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/crds/notification.toolkit.fluxcd.io_alerts.yaml" =
      [ "*.yaml" "*.yml" ];
  };
}
