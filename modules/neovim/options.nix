{ ... }:
{
  programs.nixvim.opts = {
    # Line numbers
    number = true;
    relativenumber = true;

    # Indentation (migrated from options.lua)
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartindent = true;

    # Scroll
    scrolloff = 10;

    # Splits
    splitright = true;
    splitbelow = true;

    # Search
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    incsearch = true;

    # UI
    termguicolors = true;
    cursorline = true;
    signcolumn = "yes";
    colorcolumn = "120";
    wrap = false;
    list = true;
    listchars = "tab:» ,trail:·,nbsp:␣";

    # Persistent undo
    undofile = true;

    # Performance
    updatetime = 250;
    timeoutlen = 300;

    # Clipboard
    clipboard = "unnamedplus";
  };
}
