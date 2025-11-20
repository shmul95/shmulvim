-- lua/config/option.lua
-- Set options
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.tabstop = 4 -- Tab size
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Auto-indent width

-- Always show sign column (for git signs, diagnostics, etc.)
vim.opt.signcolumn = "yes"

-- Ensure numbers & relative numbers are enabled for normal file buffers,
-- even if plugins (like explorers) turned them off in that window.
local group = vim.api.nvim_create_augroup("UserNumbers", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "BufReadPost", "BufNewFile" }, {
  group = group,
  callback = function(args)
    -- Only adjust real file buffers
    local bufnr = args.buf
    if vim.bo[bufnr].buftype == "" then
      -- Window-local options: set them for the current window
      vim.wo.number = true
      vim.wo.relativenumber = true
      vim.wo.signcolumn = "yes"
    end
  end,
})
