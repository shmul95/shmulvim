-- lua/plugins/gitsigns.lua
-- Show git changes (added/changed/deleted lines) in the sign column.

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
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
  },
}

