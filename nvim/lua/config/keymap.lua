-- lua/config/keymap.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- vim.o.langmap = "&1,é2,\"3,'4,(5,-6,è7,_8,ç9,à0"

-- Keymaps
local spaceify = { "q" }

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Ctrl + ... 
map("n", "<C-a>", "gg0vG$", opts)
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>", opts)

for _, command in ipairs(spaceify) do
	map("n", "<leader>"..command, ":"..command.."<CR>", opts)
end

--- TELESCOPE ---
map("n", "<leader>f", function() require("telescope.builtin").find_files() end, opts)

--- SNACKS ---
map("n", "<leader>e", function()
  local snacks = require("snacks")

  -- Open Snacks explorer in a vertical split (or floating, depending on config)
  snacks.picker.explorer()

  -- Wait until it's rendered
  vim.schedule(function()
    local sidebar_win = vim.api.nvim_get_current_win()

    -- Create autocmd that runs when focus moves away from the sidebar
    vim.api.nvim_create_autocmd("WinEnter", {
      callback = function()
        local current_win = vim.api.nvim_get_current_win()
        if current_win ~= sidebar_win and vim.api.nvim_win_is_valid(sidebar_win) then
          -- Close the sidebar *window* only, do not delete any buffer
          vim.api.nvim_win_close(sidebar_win, true)
        end
      end,
      once = true,
    })
  end)
end, opts)

--- HARPOON ---
local ui = require("harpoon.ui")
local mark = require("harpoon.mark")

map("n", "<leader>m", function() ui.toggle_quick_menu() end, opts)
map("n", "<leader>c", function() mark.clear_all() end, opts)
map("n", "<leader>n", function() mark.add_file() end, opts)

-- Jump to Harpoon slots 1–8 using <C-h> to <C-L>
local nav_keys = { "h", "j", "k", "l", "H", "J", "K", "L" }
for i, key in ipairs(nav_keys) do
  map("n", "<leader>".. key, function()
    ui.nav_file(i)
  end, opts)
end

