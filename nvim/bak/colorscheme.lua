return {
  {
    "catppuccin/nvim",
    -- dependencies = { "nvim-treesitter/nvim-treesitter" },
    name     = "catppuccin",
    lazy     = false,
    priority = 1000,
    opts = {
      flavour = "macchiato",
      integrations = {
        treesitter = true,
        cmp        = true,
        gitsigns   = true,
      },
      custom_highlights = function(cp)
        return {
          -- Core UI tweaks
          Normal        = { bg = "#1a1b26" },
          NormalFloat   = { bg = "#1a1b26" },
          FloatBorder   = { fg = cp.surface0, bg = "#1a1b26" },
          SignColumn    = { bg = "#1a1b26" },
          LineNr        = { fg = cp.surface2 },
          CursorLine    = { bg = "#16161D" },

          -- Syntax group overrides
          Keyword       = { fg = cp.red,     style = { "italic" } },
          Statement     = { fg = cp.red,     style = { "italic" } },
          PreProc       = { fg = cp.red,     style = { "italic" } },

          Type          = { fg = cp.sky,     style = { "italic" } },
          Constant      = { fg = cp.sky,     style = { "italic" } },

          Parameter     = { fg = cp.peach,   style = { "italic" } },

          Number        = { fg = cp.mauve                    },
          Todo          = { fg = cp.mauve                    },

          Function      = { fg = cp.green                    },
          Identifier    = { fg = cp.text                     },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
}

