{ pkgs, lib, ... }:
{
  # 1. Configure the completion engine
  vim.autocomplete.blink-cmp = {
    enable = true;
    # Ensure blink looks for the supermaven source
    setupOpts.sources.providers = {
      supermaven = {
        name = "supermaven";
        module = "blink.cmp.sources.supermaven";
        enabled = true;
      };
    };
  };

  # 2. Configure the data source (Supermaven)
  vim.assistant.supermaven-nvim = {
    enable = true;
    setupOpts = {
      # This is critical: blink handles the UI, so turn this off
      disable_inline_completion = true; 
      # Disable internal keybinds so they don't fight with blink
      disable_keymaps = true;
      log_level = "warn";
    };
  };
}
