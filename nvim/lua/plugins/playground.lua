-- lua/plugins/playground.lua
return {
  "nvim-treesitter/playground",
  cmd    = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  config = function()
    require("nvim-treesitter.configs").setup {
      playground = { enable = true },
    }
  end,
}

