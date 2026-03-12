{ ... }:
{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    settings = {
      defaults = {
        layout_strategy = "horizontal";
        layout_config.prompt_position = "top";
        sorting_strategy = "ascending";
        winblend = 0;
        mappings.i = {
          "<C-j>" = { __raw = "require('telescope.actions').move_selection_next"; };
          "<C-k>" = { __raw = "require('telescope.actions').move_selection_previous"; };
          "<C-q>" = { __raw = "require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist"; };
          "<esc>" = { __raw = "require('telescope.actions').close"; };
        };
      };
      pickers = {
        find_files.hidden = true;
        live_grep.additional_args = [ "--hidden" "--glob=!**/.git/**" ];
      };
    };
  };
}
