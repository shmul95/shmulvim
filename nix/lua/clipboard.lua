local uv = vim.uv or vim.loop
local configured_provider = vim.g.shmulvim_clipboard_provider or "auto"
local configured_register = vim.g.shmulvim_clipboard_register or "unnamedplus"

local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

local function readable_socket(path)
  local stat = uv.fs_stat(path)
  return stat ~= nil and stat.type == "socket"
end

local function can_use_wayland()
  local display = vim.env.WAYLAND_DISPLAY
  local runtime_dir = vim.env.XDG_RUNTIME_DIR

  if not display or display == "" or not runtime_dir or runtime_dir == "" then
    return false
  end

  return readable_socket(runtime_dir .. "/" .. display)
    and executable("wl-copy")
    and executable("wl-paste")
end

local function is_wsl()
  return vim.env.WSL_DISTRO_NAME ~= nil and vim.env.WSL_DISTRO_NAME ~= ""
end

local function can_use_win32yank()
  return is_wsl() and executable("win32yank.exe")
end

local function can_use_windows_clipboard()
  return is_wsl() and executable("clip.exe") and executable("powershell.exe")
end

local function can_use_xclip()
  local display = vim.env.DISPLAY
  return display and display ~= "" and executable("xclip")
end

local function set_clipboard(definition)
  vim.opt.clipboard = configured_register
  vim.g.clipboard = definition
end

local function use_wayland()
  set_clipboard({
    name = "smart-wl-clipboard",
    copy = {
      ["+"] = { "wl-copy", "--foreground", "--type", "text/plain" },
      ["*"] = { "wl-copy", "--foreground", "--primary", "--type", "text/plain" },
    },
    paste = {
      ["+"] = { "wl-paste", "--no-newline" },
      ["*"] = { "wl-paste", "--no-newline", "--primary" },
    },
    cache_enabled = 0,
  })
end

local function use_win32yank()
  set_clipboard({
    name = "smart-win32yank-clipboard",
    copy = {
      ["+"] = { "win32yank.exe", "-i", "--crlf" },
      ["*"] = { "win32yank.exe", "-i", "--crlf" },
    },
    paste = {
      ["+"] = { "win32yank.exe", "-o", "--lf" },
      ["*"] = { "win32yank.exe", "-o", "--lf" },
    },
    cache_enabled = 0,
  })
end

local function use_windows_clipboard()
  set_clipboard({
    name = "smart-windows-clipboard",
    copy = {
      ["+"] = { "clip.exe" },
      ["*"] = { "clip.exe" },
    },
    paste = {
      ["+"] = { "powershell.exe", "-NoProfile", "-Command", "Get-Clipboard -Raw" },
      ["*"] = { "powershell.exe", "-NoProfile", "-Command", "Get-Clipboard -Raw" },
    },
    cache_enabled = 0,
  })
end

local function use_xclip()
  set_clipboard({
    name = "smart-xclip-clipboard",
    copy = {
      ["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
      ["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
    },
    paste = {
      ["+"] = { "xclip", "-o", "-selection", "clipboard" },
      ["*"] = { "xclip", "-o", "-selection", "primary" },
    },
    cache_enabled = 0,
  })
end

if configured_provider == "wl-copy" and can_use_wayland() then
  use_wayland()
elseif configured_provider == "win32yank.exe" and can_use_win32yank() then
  use_win32yank()
elseif configured_provider == "clip.exe" and can_use_windows_clipboard() then
  use_windows_clipboard()
elseif configured_provider == "xclip" and can_use_xclip() then
  use_xclip()
elseif configured_provider == "auto" and can_use_win32yank() then
  use_win32yank()
elseif configured_provider == "auto" and can_use_windows_clipboard() then
  use_windows_clipboard()
elseif configured_provider == "auto" and can_use_wayland() then
  use_wayland()
elseif configured_provider == "auto" and can_use_xclip() then
  use_xclip()
end
