-- Helpers for checking which nvim-lint linters are installed
local M = {}

-- Returns the executable of a linter, or nil if it is not defined
function M.cmd(name)
  local l = require('lint').linters[name]
  if l == nil then return nil end
  if type(l) == 'function' then l = l() end
  return type(l.cmd) == 'function' and l.cmd() or l.cmd
end

function M.available(name)
  local cmd = M.cmd(name)
  return cmd ~= nil and vim.fn.executable(cmd) == 1
end

return M
