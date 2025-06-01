return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },  -- optional, for prettier floats
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  keys = {
    -- press <leader>g to open LazyGit in a float
    { "<leader>g", "<cmd>LazyGit<cr>", desc = " LazyGit" },
  },
}

