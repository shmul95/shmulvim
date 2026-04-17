local uv = vim.uv or vim.loop

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

if can_use_wayland() then
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
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
  }
elseif can_use_win32yank() then
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
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
  }
elseif can_use_windows_clipboard() then
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
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
  }
elseif can_use_xclip() then
  vim.opt.clipboard = "unnamedplus"
  vim.g.clipboard = {
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
  }
end
