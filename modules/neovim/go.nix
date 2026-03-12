{ pkgs, ... }:
{
  programs.nixvim = {
    # ── go.nvim ──────────────────────────────────────────────────────────
    extraPlugins = with pkgs.vimPlugins; [
      go-nvim
      nvim-dap-ui
    ];

    extraConfigLua = ''
      require('go').setup({
        go = 'go',
        goimports = 'gopls',
        fillstruct = 'gopls',
        gofmt = 'gofumpt',
        max_line_len = 120,
        lsp_inlay_hints = { enable = false }, -- handled by nixvim lsp.inlayHints
        dap_debug = true,
        dap_debug_gui = true,
      })

      -- DAP UI setup
      local dapui = require('dapui')
      dapui.setup()

      local dap = require('dap')
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
    '';

    # ── DAP core ─────────────────────────────────────────────────────────
    plugins.dap.enable = true;
    plugins.dap-go.enable = true;

    # ── Neotest ──────────────────────────────────────────────────────────
    plugins.neotest = {
      enable = true;
      adapters.go.enable = true;
    };

    # ── Go tooling packages ──────────────────────────────────────────────
    extraPackages = with pkgs; [
      delve
      gofumpt
      gotools # goimports
    ];
  };
}
