-- lua/plugins/harpoon.lua
return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  version = "*",
  config = function()
    require("harpoon").setup({
      -- you can leave this empty to use all defaults,
      -- or add your own settings here
      global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        enter_on_sendcmd = true,
        tmux_autoclose_windows = false,
      },
    })
  end,
}

