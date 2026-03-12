{ ... }:
{
  programs.nixvim = {
    # ── Neogit ───────────────────────────────────────────────────────────
    plugins.neogit = {
      enable = true;
      settings = {
        integrations.diffview = true;
        integrations.telescope = true;
      };
    };

    # ── Gitsigns ─────────────────────────────────────────────────────────
    plugins.gitsigns = {
      enable = true;
      settings = {
        current_line_blame = false; # toggle with <leader>gb
        signs = {
          add.text = "▎";
          change.text = "▎";
          delete.text = "";
          topdelete.text = "";
          changedelete.text = "▎";
        };
      };
    };

    # ── Diffview ─────────────────────────────────────────────────────────
    plugins.diffview = {
      enable = true;
    };
  };
}
