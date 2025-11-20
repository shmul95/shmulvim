-- lua/plugins/copilot.lua
-- GitHub Copilot integration

return {
  "github/copilot.vim",
  event = "InsertEnter",
  init = function()
    -- Don't use Copilot's default <Tab> mapping
    vim.g.copilot_no_tab_map = true

    -- Accept Copilot suggestion with <C-j> in insert mode
    vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', {
      silent = true,
      expr = true,
      replace_keycodes = false,
    })
  end,
}
