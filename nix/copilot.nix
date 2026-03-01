{ pkgs, lib, ... }:
{
  vim.assistant.copilot = {
    enable = true;
    setupOpts.suggestion = {
      enabled = true;
      auto_trigger = true;
      keymap = {
        accept = "<C-l>";     # Ctrl + l
        next = "<C-j>";       # Ctrl + j
        prev = "<C-k>";       # Ctrl + k
        dismiss = "<C-h>";    # Ctrl + h
      };
    };
  };
}
