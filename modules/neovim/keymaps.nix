{ ... }:
{
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  programs.nixvim.keymaps = [
    # ── Scroll + center ────────────────────────────────────────────────
    { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; options.desc = "Scroll down + center"; }
    { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; options.desc = "Scroll up + center"; }

    # ── Search center ──────────────────────────────────────────────────
    { mode = "n"; key = "n"; action = "nzzzv"; options.desc = "Next search result + center"; }
    { mode = "n"; key = "N"; action = "Nzzzv"; options.desc = "Prev search result + center"; }

    # ── Window navigation ──────────────────────────────────────────────
    { mode = "n"; key = "<C-h>"; action = "<C-w>h"; options.desc = "Move to left split"; }
    { mode = "n"; key = "<C-j>"; action = "<C-w>j"; options.desc = "Move to lower split"; }
    { mode = "n"; key = "<C-k>"; action = "<C-w>k"; options.desc = "Move to upper split"; }
    { mode = "n"; key = "<C-l>"; action = "<C-w>l"; options.desc = "Move to right split"; }

    # ── Splits ─────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>sv"; action = "<C-w>v"; options = { silent = true; desc = "Split vertical"; }; }
    { mode = "n"; key = "<leader>sh"; action = "<C-w>s"; options = { silent = true; desc = "Split horizontal"; }; }
    { mode = "n"; key = "<leader>sc"; action = "<C-w>c"; options = { silent = true; desc = "Close split"; }; }

    # ── File manager ───────────────────────────────────────────────────
    { mode = "n"; key = "<leader>e"; action = "<cmd>Oil<CR>"; options = { silent = true; desc = "Open file manager"; }; }
    { mode = "n"; key = "<leader>E"; action = "<cmd>Oil %:p:h<CR>"; options = { silent = true; desc = "Open file manager (current dir)"; }; }

    # ── Buffer ─────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>bd"; action = "<cmd>bdelete<CR>"; options = { silent = true; desc = "Delete buffer"; }; }
    { mode = "n"; key = "<leader>bn"; action = "<cmd>bnext<CR>"; options = { silent = true; desc = "Next buffer"; }; }
    { mode = "n"; key = "<leader>bp"; action = "<cmd>bprevious<CR>"; options = { silent = true; desc = "Prev buffer"; }; }
    { mode = "n"; key = "<leader>bD"; action = "<cmd>%bdelete|edit#|bdelete#<CR>"; options = { silent = true; desc = "Delete all other buffers"; }; }

    # ── Undo tree ──────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>u"; action = "<cmd>UndotreeToggle<CR>"; options = { silent = true; desc = "Toggle undo tree"; }; }

    # ── Find (Telescope) ───────────────────────────────────────────────
    { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options = { silent = true; desc = "Find files"; }; }
    { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>"; options = { silent = true; desc = "Live grep"; }; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>"; options = { silent = true; desc = "Find buffers"; }; }
    { mode = "n"; key = "<leader>fr"; action = "<cmd>Telescope oldfiles<CR>"; options = { silent = true; desc = "Recent files"; }; }
    { mode = "n"; key = "<leader>fs"; action = "<cmd>Telescope lsp_document_symbols<CR>"; options = { silent = true; desc = "Document symbols"; }; }
    { mode = "n"; key = "<leader>fS"; action = "<cmd>Telescope lsp_workspace_symbols<CR>"; options = { silent = true; desc = "Workspace symbols"; }; }
    { mode = "n"; key = "<leader>fd"; action = "<cmd>Telescope diagnostics<CR>"; options = { silent = true; desc = "Diagnostics"; }; }
    { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<CR>"; options = { silent = true; desc = "Help tags"; }; }
    { mode = "n"; key = "<leader>f/"; action = "<cmd>Telescope current_buffer_fuzzy_find<CR>"; options = { silent = true; desc = "Grep current buffer"; }; }

    # ── Git ────────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>gg"; action = "<cmd>Neogit<CR>"; options = { silent = true; desc = "Open Neogit"; }; }
    { mode = "n"; key = "<leader>gd"; action = "<cmd>DiffviewOpen<CR>"; options = { silent = true; desc = "Open diffview"; }; }
    { mode = "n"; key = "<leader>gD"; action = "<cmd>DiffviewFileHistory<CR>"; options = { silent = true; desc = "Diff history"; }; }
    { mode = "n"; key = "<leader>gB"; action = "<cmd>Telescope git_branches<CR>"; options = { silent = true; desc = "Git branches"; }; }
    { mode = "n"; key = "<leader>gc"; action = "<cmd>Telescope git_commits<CR>"; options = { silent = true; desc = "Git commits"; }; }
    { mode = "n"; key = "<leader>gb"; action = "<cmd>Gitsigns blame_line<CR>"; options = { silent = true; desc = "Blame line"; }; }
    { mode = "n"; key = "<leader>gs"; action = "<cmd>Gitsigns stage_hunk<CR>"; options = { silent = true; desc = "Stage hunk"; }; }
    { mode = "n"; key = "<leader>gu"; action = "<cmd>Gitsigns undo_stage_hunk<CR>"; options = { silent = true; desc = "Undo stage hunk"; }; }
    { mode = "n"; key = "<leader>gp"; action = "<cmd>Gitsigns preview_hunk<CR>"; options = { silent = true; desc = "Preview hunk"; }; }
    { mode = "n"; key = "[h"; action = "<cmd>Gitsigns prev_hunk<CR>"; options = { silent = true; desc = "Prev hunk"; }; }
    { mode = "n"; key = "]h"; action = "<cmd>Gitsigns next_hunk<CR>"; options = { silent = true; desc = "Next hunk"; }; }

    # ── LSP ────────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>lr"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options = { silent = true; desc = "Rename symbol"; }; }
    { mode = "n"; key = "<leader>la"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options = { silent = true; desc = "Code action"; }; }
    { mode = "n"; key = "<leader>lf"; action = "<cmd>lua require('conform').format({ async = true })<CR>"; options = { silent = true; desc = "Format buffer"; }; }
    { mode = "n"; key = "<leader>ld"; action = "<cmd>Trouble diagnostics<CR>"; options = { silent = true; desc = "Diagnostics (Trouble)"; }; }
    { mode = "n"; key = "<leader>li"; action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>"; options = { silent = true; desc = "Toggle inlay hints"; }; }
    { mode = "n"; key = "<leader>lR"; action = "<cmd>LspRestart<CR>"; options = { silent = true; desc = "Restart LSP"; }; }

    # Standard LSP navigation
    { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; options = { silent = true; desc = "Go to definition"; }; }
    { mode = "n"; key = "gD"; action = "<cmd>lua vim.lsp.buf.declaration()<CR>"; options = { silent = true; desc = "Go to declaration"; }; }
    { mode = "n"; key = "gr"; action = "<cmd>Telescope lsp_references<CR>"; options = { silent = true; desc = "Find references"; }; }
    { mode = "n"; key = "gi"; action = "<cmd>lua vim.lsp.buf.implementation()<CR>"; options = { silent = true; desc = "Go to implementation"; }; }
    { mode = "n"; key = "gy"; action = "<cmd>lua vim.lsp.buf.type_definition()<CR>"; options = { silent = true; desc = "Go to type definition"; }; }
    { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options = { silent = true; desc = "Hover docs"; }; }
    { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; options = { silent = true; desc = "Prev diagnostic"; }; }
    { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; options = { silent = true; desc = "Next diagnostic"; }; }

    # ── Debug ──────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>db"; action = "<cmd>lua require('dap').toggle_breakpoint()<CR>"; options = { silent = true; desc = "Toggle breakpoint"; }; }
    { mode = "n"; key = "<leader>dB"; action = "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Condition: '))<CR>"; options = { silent = true; desc = "Conditional breakpoint"; }; }
    { mode = "n"; key = "<leader>dc"; action = "<cmd>lua require('dap').continue()<CR>"; options = { silent = true; desc = "Continue/start"; }; }
    { mode = "n"; key = "<leader>dn"; action = "<cmd>lua require('dap').step_over()<CR>"; options = { silent = true; desc = "Step over"; }; }
    { mode = "n"; key = "<leader>ds"; action = "<cmd>lua require('dap').step_into()<CR>"; options = { silent = true; desc = "Step into"; }; }
    { mode = "n"; key = "<leader>do"; action = "<cmd>lua require('dap').step_out()<CR>"; options = { silent = true; desc = "Step out"; }; }
    { mode = "n"; key = "<leader>dt"; action = "<cmd>lua require('dap').terminate()<CR>"; options = { silent = true; desc = "Terminate session"; }; }
    { mode = "n"; key = "<leader>du"; action = "<cmd>lua require('dapui').toggle()<CR>"; options = { silent = true; desc = "Toggle DAP UI"; }; }
    { mode = "n"; key = "<leader>dl"; action = "<cmd>lua require('dap').run_last()<CR>"; options = { silent = true; desc = "Run last debug config"; }; }

    # ── Test ───────────────────────────────────────────────────────────
    { mode = "n"; key = "<leader>tt"; action = "<cmd>lua require('neotest').run.run()<CR>"; options = { silent = true; desc = "Run nearest test"; }; }
    { mode = "n"; key = "<leader>tf"; action = "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>"; options = { silent = true; desc = "Run file tests"; }; }
    { mode = "n"; key = "<leader>ts"; action = "<cmd>lua require('neotest').summary.toggle()<CR>"; options = { silent = true; desc = "Toggle test summary"; }; }
    { mode = "n"; key = "<leader>to"; action = "<cmd>lua require('neotest').output_panel.toggle()<CR>"; options = { silent = true; desc = "Toggle test output"; }; }
    { mode = "n"; key = "<leader>tS"; action = "<cmd>lua require('neotest').run.stop()<CR>"; options = { silent = true; desc = "Stop test run"; }; }
    { mode = "n"; key = "[t"; action = "<cmd>lua require('neotest').jump.prev({ status = 'failed' })<CR>"; options = { silent = true; desc = "Prev failed test"; }; }
    { mode = "n"; key = "]t"; action = "<cmd>lua require('neotest').jump.next({ status = 'failed' })<CR>"; options = { silent = true; desc = "Next failed test"; }; }

    # ── Harpoon (harpoon2 API) ─────────────────────────────────────────
    { mode = "n"; key = "<leader>ha"; action = { __raw = "function() require('harpoon'):list():add() end"; }; options = { silent = true; desc = "Harpoon add file"; }; }
    { mode = "n"; key = "<leader>hh"; action = { __raw = "function() local h = require('harpoon') h.ui:toggle_quick_menu(h:list()) end"; }; options = { silent = true; desc = "Harpoon menu"; }; }
    { mode = "n"; key = "<leader>1"; action = { __raw = "function() require('harpoon'):list():select(1) end"; }; options = { silent = true; desc = "Harpoon slot 1"; }; }
    { mode = "n"; key = "<leader>2"; action = { __raw = "function() require('harpoon'):list():select(2) end"; }; options = { silent = true; desc = "Harpoon slot 2"; }; }
    { mode = "n"; key = "<leader>3"; action = { __raw = "function() require('harpoon'):list():select(3) end"; }; options = { silent = true; desc = "Harpoon slot 3"; }; }
    { mode = "n"; key = "<leader>4"; action = { __raw = "function() require('harpoon'):list():select(4) end"; }; options = { silent = true; desc = "Harpoon slot 4"; }; }

    # ── GoLand / IntelliJ compatible bindings ──────────────────────────
    # Delete line (GoLand Ctrl-y)
    { mode = "n"; key = "<C-y>"; action = "dd"; options = { silent = true; desc = "Delete current line"; }; }
    # Search
    { mode = "n"; key = "<C-S-f>"; action = "<cmd>Telescope live_grep<CR>"; options = { silent = true; desc = "Find in path"; }; }
    { mode = "n"; key = "<C-S-n>"; action = "<cmd>Telescope find_files<CR>"; options = { silent = true; desc = "Navigate to file"; }; }
    { mode = "n"; key = "<C-e>"; action = "<cmd>Telescope oldfiles<CR>"; options = { silent = true; desc = "Recent files"; }; }
    { mode = "n"; key = "<C-F12>"; action = "<cmd>Telescope lsp_document_symbols<CR>"; options = { silent = true; desc = "File structure"; }; }
    # Navigation
    { mode = "n"; key = "<C-b>"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; options = { silent = true; desc = "Go to definition"; }; }
    { mode = "n"; key = "<A-F7>"; action = "<cmd>Telescope lsp_references<CR>"; options = { silent = true; desc = "Find usages"; }; }
    { mode = "n"; key = "<F2>"; action = "<cmd>lua vim.diagnostic.goto_next()<CR>"; options = { silent = true; desc = "Next error"; }; }
    { mode = "n"; key = "<S-F2>"; action = "<cmd>lua vim.diagnostic.goto_prev()<CR>"; options = { silent = true; desc = "Prev error"; }; }
    # Editing
    { mode = "n"; key = "<S-F6>"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options = { silent = true; desc = "Rename symbol"; }; }
    { mode = "n"; key = "<A-CR>"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options = { silent = true; desc = "Code action"; }; }
    { mode = "n"; key = "<C-A-l>"; action = "<cmd>lua require('conform').format({ async = true })<CR>"; options = { silent = true; desc = "Reformat code"; }; }
    # Debug
    { mode = "n"; key = "<C-F8>"; action = "<cmd>lua require('dap').toggle_breakpoint()<CR>"; options = { silent = true; desc = "Toggle breakpoint"; }; }
    { mode = "n"; key = "<F9>"; action = "<cmd>lua require('dap').continue()<CR>"; options = { silent = true; desc = "Resume/continue"; }; }
    { mode = "n"; key = "<F8>"; action = "<cmd>lua require('dap').step_over()<CR>"; options = { silent = true; desc = "Step over"; }; }
    { mode = "n"; key = "<F7>"; action = "<cmd>lua require('dap').step_into()<CR>"; options = { silent = true; desc = "Step into"; }; }
    { mode = "n"; key = "<S-F8>"; action = "<cmd>lua require('dap').step_out()<CR>"; options = { silent = true; desc = "Step out"; }; }
    { mode = "n"; key = "<A-F8>"; action = "<cmd>lua require('dapui').eval()<CR>"; options = { silent = true; desc = "Evaluate expression"; }; }
    # Test
    { mode = "n"; key = "<C-S-F10>"; action = "<cmd>lua require('neotest').run.run()<CR>"; options = { silent = true; desc = "Run nearest test"; }; }
    { mode = "n"; key = "<C-F5>"; action = "<cmd>lua require('neotest').run.run_last()<CR>"; options = { silent = true; desc = "Rerun last test"; }; }
  ];
}
