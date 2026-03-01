local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Keymaps

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Ctrl + ... 
map("n", "<C-a>", "gg0vG$", opts)
map("n", "<C-s>", ":w<CR>", opts)
map("i", "<C-s>", "<Esc>:w<CR>", opts)

-- leader = :
local spaceify = { "q" }

for _, command in ipairs(spaceify) do
	map("n", "<leader>"..command, ":"..command.."<CR>", opts)
end

