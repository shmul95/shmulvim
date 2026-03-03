-- snacks.lua
-- Configuration for snacks.nvim
-- This assumes snacks.nvim is already loaded via nvf configuration

local snacks = require('snacks')

snacks.setup({
  explorer = { enabled = true },
  picker   = {
    enabled = true,
    sources = {
      explorer = {
        auto_close = true,
        jump = { close = true },
      },
    },
  },
})
