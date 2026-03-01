{ pkgs, lib, ... }:
{
  vim.telescope = {
    enable = true;
    mappings = {
      findFiles = "<leader>f";
      liveGrep = "<leader>r";
      buffers = "<leader>b";
      findProjects = null;
      helpTags = null;
      open = null;
      resume = null;

      gitFiles = null;
      gitCommits = null;
      gitBufferCommits = null;
      gitBranches = null;
      gitStatus = null;
      gitStash = null;

      lspDocumentSymbols = null;
      lspWorkspaceSymbols = null;
      lspReferences = null;
      lspImplementations = null;
      lspDefinitions = null;
      lspTypeDefinitions = null;
      diagnostics = null;

      treesitter = null;
    };
  };
}
