{ pkgs, ... }:
{
  programs.nixvim = {
    # ── OpenTofu LSP ──────────────────────────────────────────────────────
    # opentofu-ls is a drop-in replacement for terraform-ls.
    # Substitute the package and extend filetypes to cover .tofu files.
    # See: https://github.com/nix-community/nixvim/issues/3002
    plugins.lsp.servers.terraformls = {
      enable = true;
      package = pkgs.opentofu-ls;
      filetypes = [ "terraform" "terraform-vars" "tofu" ];
    };

    # ── Formatting ───────────────────────────────────────────────────────
    plugins.conform-nvim.settings.formatters_by_ft = {
      terraform = [ "tofu_fmt" ];
      "terraform-vars" = [ "tofu_fmt" ];
      tofu = [ "tofu_fmt" ];
    };

    # ── Binaries ─────────────────────────────────────────────────────────
    extraPackages = with pkgs; [
      opentofu
      opentofu-ls
      tflint
    ];
  };
}
