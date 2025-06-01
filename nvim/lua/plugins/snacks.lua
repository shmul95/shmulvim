-- lua/plugins/snacks.lua
return {
  "folke/snacks.nvim",
  -- make sure it’s loaded at startup so the explorer command exists
  priority = 1000,
  lazy     = false,
  ---@type snacks.Config
  opts = {
    -- enable only the explorer and the picker core
    explorer = { enabled = true },
    picker   = { enabled = true },
  },
}

