-- Normalize vim.lsp.Client:request calls across Neovim/CMP versions
-- Fixes cases where bufnr becomes a function due to colon/dot call mismatches.

local M = {}

local function get_clients(opts)
  local get = vim.lsp.get_clients or vim.lsp.get_active_clients
  return get(opts or {})
end

local function patch_client(client)
  if not client or type(client) ~= "table" then
    return
  end
  if client._codex_request_patched then
    return
  end

  local orig = client.request
  if type(orig) ~= "function" then
    return
  end

  -- Wrap to accept both colon and dot styles and ensure numeric bufnr
  client.request = function(...)
    local argc = select("#", ...)
    if argc == 0 then
      return orig(...)
    end

    local a1 = select(1, ...)
    local a2 = select(2, ...)

    local method, params, handler, bufnr

    if type(a1) == "table" and type(a2) == "string" then
      -- Called as client:request(method, params, handler, bufnr)
      method = a2
      params = select(3, ...)
      handler = select(4, ...)
      bufnr  = select(5, ...)
    else
      -- Called as client.request(method, params, handler, bufnr)
      method = a1
      params = select(2, ...)
      handler = select(3, ...)
      bufnr  = select(4, ...)
    end

    -- Some callers accidentally pass a function as the 4th arg (notify cb);
    -- LSP client expects bufnr here. Default to current (0).
    if type(bufnr) == "function" or type(bufnr) == "table" then
      bufnr = 0
    end
    if bufnr == nil then
      bufnr = 0
    end

    return orig(method, params, handler, bufnr)
  end

  client._codex_request_patched = true
end

function M.setup()
  -- Patch any already-running clients
  for _, client in ipairs(get_clients()) do
    pcall(patch_client, client)
  end

  -- Patch future clients on attach
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("compat_lsp_request_patch", { clear = true }),
    callback = function(args)
      local id = args.data and args.data.client_id or nil
      if not id then return end
      local client = vim.lsp.get_client_by_id(id)
      if client then
        pcall(patch_client, client)
      end
    end,
  })

  -- Safety: also run once on InsertEnter before cmp kicks in
  vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("compat_lsp_request_patch_once", { clear = true }),
    once = true,
    callback = function()
      for _, client in ipairs(get_clients()) do
        pcall(patch_client, client)
      end
    end,
  })
end

return M

