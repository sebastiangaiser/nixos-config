{ pkgs, ... }:
{
  programs.nixvim = {
    # ── LSP ──────────────────────────────────────────────────────────────
    plugins.lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        gopls = {
          enable = true;
          settings = {
            hints = {
              assignVariableTypes = true;
              compositeLiteralFields = true;
              compositeLiteralTypes = true;
              constantValues = true;
              functionTypeParameters = true;
              parameterNames = true;
              rangeVariableTypes = true;
            };
          };
        };
        nixd.enable = true;
        yamlls.enable = true;
        jsonls.enable = true;
        bashls.enable = true;
        helm_ls.enable = true;
      };
    };

    # ── Completion ───────────────────────────────────────────────────────
    plugins.blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "default";
        appearance = {
          use_nvim_cmp_as_default = true;
          nerd_font_variant = "mono";
        };
        sources.default = [ "lsp" "path" "snippets" "buffer" ];
        completion = {
          documentation.auto_show = true;
          ghost_text.enabled = true;
        };
        signature.enabled = true;
      };
    };

    # ── Formatting ───────────────────────────────────────────────────────
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          go = [ "goimports" "gofumpt" ];
          nix = [ "nixfmt" ];
          sh = [ "shfmt" ];
          bash = [ "shfmt" ];
          yaml = [ "prettier" ];
          json = [ "prettier" ];
        };
        format_on_save = {
          timeout_ms = 500;
          lsp_fallback = true;
        };
      };
    };

    # ── Diagnostics UI ───────────────────────────────────────────────────
    plugins.trouble = {
      enable = true;
      settings.modes.diagnostics.auto_close = true;
    };

    # ── Extra packages for formatters ────────────────────────────────────
    extraPackages = with pkgs; [
      gotools     # provides goimports
      nodePackages.prettier
      shfmt
      nixfmt-rfc-style
    ];
  };
}
