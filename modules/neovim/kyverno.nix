{ ... }:
let
  all = [ "*.yaml" "*.yml" ];
  k = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/kyverno.io";
  p = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/policies.kyverno.io";
in
{
  programs.nixvim.plugins.lsp.servers.yamlls.settings.yaml.schemas = {
    # ── kyverno.io ───────────────────────────────────────────────────────
    "${k}/clusterpolicy_v1.json" = all;
    "${k}/clusterpolicy_v2beta1.json" = all;
    "${k}/policy_v1.json" = all;
    "${k}/policy_v2beta1.json" = all;
    "${k}/clustercleanuppolicy_v2.json" = all;
    "${k}/clustercleanuppolicy_v2alpha1.json" = all;
    "${k}/clustercleanuppolicy_v2beta1.json" = all;
    "${k}/cleanuppolicy_v2.json" = all;
    "${k}/cleanuppolicy_v2alpha1.json" = all;
    "${k}/cleanuppolicy_v2beta1.json" = all;
    "${k}/policyexception_v2.json" = all;
    "${k}/policyexception_v2alpha1.json" = all;
    "${k}/policyexception_v2beta1.json" = all;
    "${k}/globalcontextentry_v2.json" = all;
    "${k}/globalcontextentry_v2alpha1.json" = all;
    "${k}/globalcontextentry_v2beta1.json" = all;

    # ── policies.kyverno.io (CEL-based policies) ─────────────────────────
    "${p}/validatingpolicy_v1.json" = all;
    "${p}/validatingpolicy_v1alpha1.json" = all;
    "${p}/validatingpolicy_v1beta1.json" = all;
    "${p}/namespacedvalidatingpolicy_v1.json" = all;
    "${p}/namespacedvalidatingpolicy_v1beta1.json" = all;
    "${p}/mutatingpolicy_v1.json" = all;
    "${p}/mutatingpolicy_v1alpha1.json" = all;
    "${p}/mutatingpolicy_v1beta1.json" = all;
    "${p}/namespacedmutatingpolicy_v1.json" = all;
    "${p}/namespacedmutatingpolicy_v1beta1.json" = all;
    "${p}/imagevalidatingpolicy_v1.json" = all;
    "${p}/imagevalidatingpolicy_v1alpha1.json" = all;
    "${p}/imagevalidatingpolicy_v1beta1.json" = all;
    "${p}/namespacedimagevalidatingpolicy_v1.json" = all;
    "${p}/namespacedimagevalidatingpolicy_v1beta1.json" = all;
    "${p}/generatingpolicy_v1.json" = all;
    "${p}/generatingpolicy_v1alpha1.json" = all;
    "${p}/generatingpolicy_v1beta1.json" = all;
    "${p}/namespacedgeneratingpolicy_v1.json" = all;
    "${p}/namespacedgeneratingpolicy_v1beta1.json" = all;
    "${p}/deletingpolicy_v1.json" = all;
    "${p}/deletingpolicy_v1alpha1.json" = all;
    "${p}/deletingpolicy_v1beta1.json" = all;
    "${p}/namespaceddeletingpolicy_v1.json" = all;
    "${p}/namespaceddeletingpolicy_v1beta1.json" = all;
    "${p}/policyexception_v1.json" = all;
    "${p}/policyexception_v1alpha1.json" = all;
    "${p}/policyexception_v1beta1.json" = all;
    "${p}/policyexception_v2.json" = all;
    "${p}/policyexception_v2beta1.json" = all;
  };
}
