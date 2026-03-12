{ pkgs, ... }:
{
  programs.nixvim = {
    # ── Colorscheme (catppuccin) ──────────────────────────────────────────
    # catppuccin.nix manages other tools; nixvim owns the neovim colorscheme
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha";
        integrations = {
          blink_cmp = true;
          diffview = true;
          gitsigns = true;
          harpoon = true;
          indent_blankline.enabled = true;
          lsp_trouble = true;
          mini.enabled = true;
          neogit = true;
          noice = true;
          nvim_dap = true;
          nvim_dap_ui = true;
          neotest = true;
          oil = true;
          telescope.enabled = true;
          treesitter = true;
          which_key = true;
        };
      };
    };

    # ── Statusline ───────────────────────────────────────────────────────
    plugins.lualine = {
      enable = true;
      settings.options = {
        theme = "catppuccin";
        globalstatus = true;
        component_separators = { left = ""; right = ""; };
        section_separators = { left = ""; right = ""; };
      };
    };

    # ── Buffer tabs ──────────────────────────────────────────────────────
    plugins.bufferline = {
      enable = true;
      settings.options = {
        separator_style = "slant";
        diagnostics = "nvim_lsp";
        show_buffer_close_icons = false;
        show_close_icon = false;
      };
    };

    # ── Which-key ────────────────────────────────────────────────────────
    plugins.which-key = {
      enable = true;
      settings.spec = [
        { __unkeyed-1 = "<leader>b"; group = "buffer"; }
        { __unkeyed-1 = "<leader>d"; group = "debug"; }
        { __unkeyed-1 = "<leader>f"; group = "find"; }
        { __unkeyed-1 = "<leader>g"; group = "git"; }
        { __unkeyed-1 = "<leader>h"; group = "harpoon"; }
        { __unkeyed-1 = "<leader>l"; group = "lsp"; }
        { __unkeyed-1 = "<leader>s"; group = "splits"; }
        { __unkeyed-1 = "<leader>t"; group = "test"; }
      ];
    };

    # ── Notifications / command UI ───────────────────────────────────────
    plugins.noice = {
      enable = true;
      settings = {
        lsp.override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = false;
        };
      };
    };

    # ── File manager ─────────────────────────────────────────────────────
    plugins.oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        delete_to_trash = true;
        view_options.show_hidden = true;
      };
    };

    # ── Harpoon ──────────────────────────────────────────────────────────
    plugins.harpoon = {
      enable = true;
      enableTelescope = true;
    };

    # ── Indent guides ────────────────────────────────────────────────────
    plugins.indent-blankline = {
      enable = true;
      settings = {
        indent.char = "│";
        scope.enabled = true;
      };
    };

    # ── Treesitter ───────────────────────────────────────────────────────
    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-space>";
            node_incremental = "<C-space>";
            scope_incremental = false;
            node_decremental = "<bs>";
          };
        };
      };
    };

    # ── Editing helpers ──────────────────────────────────────────────────
    plugins.nvim-autopairs.enable = true;
    plugins.vim-surround.enable = true;
    plugins.comment.enable = true;
    plugins.mini = {
      enable = true;
      modules.ai = {};
      modules.icons = {};
      mockDevIcons = true;
    };

    # ── Dashboard ────────────────────────────────────────────────────────
    plugins.dashboard.enable = true;

    # ── Undo tree ────────────────────────────────────────────────────────
    plugins.undotree.enable = true;
  };
}
