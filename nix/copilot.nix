{ pkgs, lib, ... }:
{
  vim.assistant.copilot = {
    enable = true;
    setupOpts = {
      # 1. Enable inline ghost text
      suggestion = {
        enabled = true;
        auto_trigger = true; # Suggestions appear automatically
        keymap = {
          accept = "<M-l>";     # 'Alt + l' to accept
          next = "<M-j>";       # 'Alt + j' for next suggestion
          prev = "<M-k>";       # 'Alt + k' for previous suggestion
          dismiss = "<M-h>";    # 'Alt + h' to hide
        };
      };
      
      # 2. Disable the panel so you don't get unnecessary popups
      panel = {
        enabled = false;
      };
    };
  };
}
