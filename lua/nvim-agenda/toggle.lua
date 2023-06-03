local Utils = require "nvim-agenda.utils"

local M = {}

function M.toggle(to)
  local to_kw = M.check_keyword(to)
  local line = vim.api.nvim_get_current_line()
  local from_kw = Utils.match_keyword(line)

  assert(from_kw, "no keyword found on current line")
  if from_kw ~= nil then
    local toggle_line = string.gsub(line, from_kw, to_kw, 1)
    vim.api.nvim_set_current_line(toggle_line)
  end
end

function M.check_keyword(kw)
  local kw_to = string.gsub(kw, "to=", "", 1)

  assert(Utils.match_keyword(kw_to), "'to' keyword must be recognised keyword in config")
  return kw_to
end

return M
