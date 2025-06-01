-- lua/pluggins/treesitters.lua

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",          -- install/update parsers after install
  lazy  = false,                -- load on startup
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "c", "cpp", "rust", "python", "lua" },
      highlight = {
        enable = true,          -- turn on TS highlighting
        -- additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    }
  end,
}

