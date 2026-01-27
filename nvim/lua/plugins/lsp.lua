-- lua/plugins/mason.lua
-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      -- install/manage LSP servers
      { "williamboman/mason.nvim",       config = true },
      { "williamboman/mason-lspconfig.nvim" },
      -- lua-specific completions & settings
      { "folke/neodev.nvim",             opts = { library = { plugins = { "nvim-dap-ui" }, types = true } } },
      -- show LSP progress
      { "j-hui/fidget.nvim",             tag = "legacy", opts = {} },
    },
    config = function()
      local mason_lsp = require("mason-lspconfig")
      require("mason").setup()
      mason_lsp.setup({
        ensure_installed = {
          "bashls",        -- shell
          "clangd",        -- C/C++
          "cssls",         -- CSS
          "dockerls",      -- Dockerfiles
          "gopls",         -- Go
          "html",          -- HTML
          "jsonls",        -- JSON
          "marksman",      -- Markdown
          "pyright",       -- Python
          "rust_analyzer", -- Rust
          "sqlls",         -- SQL
          "tailwindcss",   -- Tailwind
          "lua_ls",        -- Lua
          "yamlls",        -- YAML
        },
        automatic_installation = true,
      })

      -- common on_attach + capabilities
      local on_attach = function(_, bufnr)
        local nmap = function(keys, fn, desc)
          if desc then desc = "LSP: " .. desc end
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
        end

        nmap("gd", vim.lsp.buf.definition,     "[G]oto [D]efinition")
        nmap("gr", vim.lsp.buf.references,     "[G]oto [R]eferences")
        nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        nmap("K",  vim.lsp.buf.hover,          "Hover Documentation")
        nmap("<leader>rn", vim.lsp.buf.rename,    "[R]e[n]ame")
        nmap("ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        nmap("[d", vim.diagnostic.goto_prev,     "Previous Diagnostic")
        nmap("]d", vim.diagnostic.goto_next,     "Next Diagnostic")
        nmap("<leader>lf", vim.lsp.buf.format,       "[F]ormat buffer")
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- finally, loop through and set up each server
      mason_lsp.setup_handlers({
        function(server_name)
          vim.lsp.config(server_name, {
            on_attach    = on_attach,
            capabilities = capabilities,
          })
        end,
      })
    end,
  },
}

