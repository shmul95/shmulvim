-- lua/plugins/catppuccin.lua
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,  -- Load immediately to ensure colorscheme is available
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- or "latte", "frappe", "macchiato"
      integrations = {
        treesitter = true,
        -- other integrations like cmp, telescope, etc.
      },
      compile    = { enabled = false },
      highlight_overrides = {
        all = function(colors)
          return {
            ["@keyword"]  = { fg = colors.red, style = { "italic" } },
            ["@keyword.operator"]  = { fg = colors.red },
            ["@keyword.return"]  = { fg = colors.red, style = { "italic" } },
            ["@keyword.repeat"]  = { fg = colors.red, style = { "italic" } },
            ["@keyword.conditional"]  = { fg = colors.red, style = { "italic" } },
            ["@keyword.conditional.ternary"]  = { fg = colors.red, style = { "italic" } },
            ["@keyword.directive"]  = { fg = colors.red },
            ["@keyword.directive.define"]  = { fg = colors.red },
            ["@keyword.import"]  = { fg = colors.red },
            ["@keyword.modifier"]  = { fg = colors.red, style = { "italic" } },
            ["@keyword.function"]  = { fg = colors.red, style = { "italic" } },

            ["@function"] = { fg = colors.green },
            ["@function.call"] = { fg = colors.green },
            ["@variable"] = { fg = colors.text },
            ["@variable.parameter"] = { fg = colors.peach },

            ["@type"]     = { fg = colors.sapphire },
            ["@keyword.type"]     = { fg = colors.sapphire },
            ["@boolean"]     = { fg = colors.sapphire , style = { "bold" }},
            ["@type.definition"]     = { fg = colors.sapphire, style = { "italic" } },
            ["@type.primitive"]     = { fg = colors.sapphire, style = { "italic" } },
            ["@type.builtin"]     = { fg = colors.sapphire, style = { "italic" } },
            ["@type.builtin.c"]     = { fg = colors.sapphire, style = { "italic" } },
            ["@type.builtin.cpp"]     = { fg = colors.sapphire, style = { "italic" } },

            ["@operator"] = { fg = colors.red, style = { "italic" } },
            ["@comment"]  = { fg = colors.overlay1, style = { "italic" } },
          }
        end,
      },
    })

    vim.cmd.colorscheme("catppuccin")
    
    -- Ensure colorscheme is applied immediately
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("catppuccin_ensure", { clear = true }),
      callback = function()
        vim.cmd.colorscheme("catppuccin")
      end,
    })
  end,
}
