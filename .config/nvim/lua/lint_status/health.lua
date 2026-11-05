-- :checkhealth lint_status
local M = {}

function M.check()
  local status = require('lint_status')
  local by_ft = require('lint').linters_by_ft
  local seen = {}
  vim.health.start('nvim-lint linters')
  for ft, names in vim.spairs(by_ft) do
    for _, name in ipairs(names) do
      if not seen[name] then
        seen[name] = true
        local cmd = status.cmd(name)
        if cmd == nil then
          vim.health.error(name .. ' (' .. ft .. '): unknown linter')
        elseif status.available(name) then
          vim.health.ok(name .. ' (' .. ft .. '): ' .. vim.fn.exepath(cmd))
        else
          vim.health.warn(name .. ' (' .. ft .. '): executable "' .. cmd .. '" not found')
        end
      end
    end
  end
end

return M
