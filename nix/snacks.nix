{ pkgs, lib, ... }:
{
  vim.extraPlugins = {
    snacks-nvim = {
      package = pkgs.vimPlugins.snacks-nvim;
      setup = /* lua */''
        require('snacks').setup({
          explorer = { enabled = true },
          picker   = {
            enabled = true,
            sources = {
              explorer = {
                hidden = true,
                ignored = true,
                auto_close = true,
                jump = { close = true },
              },
            },
          },
        })
        
        -- Keymap for snacks explorer
        vim.keymap.set("n", "<leader>e", function()
          Snacks.explorer()
        end, { desc = "Toggle file explorer" })
      '';
    };
  };
}
