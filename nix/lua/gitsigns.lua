-- gitsigns.lua
-- Show git changes (added/changed/deleted lines) in the sign column.
-- This assumes gitsigns is already loaded via nvf configuration

local gitsigns = require('gitsigns')

gitsigns.setup({
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  signcolumn = true, -- show symbols in the sign column
  numhl      = true, -- highlight line numbers for changed lines (VS Code-like)
  linehl     = false,
  word_diff  = false,
})

