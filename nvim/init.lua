--- init.lua
local fn = vim.fn
local config_path = fn.stdpath('config')            -- e.g. ~/.config/nvim
local lua_path    = config_path .. '/lua'

vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 4 -- Tab size
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Auto-indent width

-- Append the system clipboard (“+” register) to the unnamed registers
vim.o.clipboard = "unnamedplus"

vim.filetype.add({
    extension = {
        tpp = "cpp",
    },
})

-- Epitech Headers

local function insert_header()
    -- Get file name without extension and current directory name
    local file = vim.fn.expand("%:t:r")
    local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    local year = os.date("%Y")

    -- Define the header lines
    local lines = {
        "/*",
        "** EPITECH PROJECT, " .. year,
        "** " .. dir,
        "** File description:",
        "** " .. file,
        "*/",
        ""
    }

    -- Insert lines at the top of the buffer
    vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

-- Map Ctrl+e in normal mode to insert the header
vim.keymap.set("n", "<C-e>", insert_header, { noremap = true, silent = true })

-- Stub out the removed `vim.lsp.enable()` so mason-lspconfig won't error
if not vim.lsp.enable then
  vim.lsp.enable = function(...) end
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 1) bootstrap lazy.nvim into your runtime path
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.o.termguicolors = true
vim.opt.rtp:prepend(lazypath)

-- auto cargo fmt for rust files
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.rs",
    callback = function ()
        vim.fn.jobstart("cargo fmt")
    end,
})

require("lazy").setup("plugins")
require("config.option")
require("config.keymap")

-- Ensure LSP request compatibility so completion doesn't error on bufnr
pcall(function()
  require("compat.lsp").setup()
end)
