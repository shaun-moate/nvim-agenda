local Colors = require("nvim-agenda.colors")

local M = {}

M.namespace = vim.api.nvim_create_namespace("nvim-agenda")
M.options = {}

local defaults = {
  find_lines_keywords = { "TODO" },
  keywords = {
    TODO = { icon = " ", color = "AgendaYellow" },
    DONE = { icon = " ", color = "AgendaGreen" },
  },
  signs = true,
  signs_priority = 99,
  throttle = 200,
  pattern = [[\KEYWORDS]],
}

function M._setup(customOptions)
  M.options = vim.tbl_deep_extend("force", {}, defaults, customOptions or {})

  function M.tags(keywords)
    local kws = keywords or vim.tbl_keys(M.options.keywords)
    table.sort(kws, function(a, b)
      return #b < #a
    end)
    return table.concat(kws, "|")
  end

  M.hl_regex = {}
  local patterns = M.options.pattern
  patterns = type(patterns) == "table" and patterns or { patterns }
  for _, p in pairs(patterns) do
    p = p:gsub("KEYWORDS", M.tags())
    table.insert(M.hl_regex, p)
  end

  M.set_colors()
  M.signs()
  require("nvim-agenda.highlight").start()
  M.loaded = true
end

function M.signs()
  for kw, opts in pairs(M.options.keywords) do
    vim.fn.sign_define("agenda-sign-" .. kw, {
      text = opts.icon,
      texthl = opts.color,
    })
  end
end

function M.set_colors()
  local colorscheme = M.options.theme

  if M.tableHasKey(Colors, colorscheme) then
    vim.api.nvim_set_hl(0, "AgendaGreen",  { fg = Colors[colorscheme].green, bg = Colors[colorscheme].dark_bg })
    vim.api.nvim_set_hl(0, "AgendaYellow", { fg = Colors[colorscheme].yellow, bg = Colors[colorscheme].dark_bg })
    vim.api.nvim_set_hl(0, "AgendaOrange", { fg = Colors[colorscheme].orange, bg = Colors[colorscheme].dark_bg })
    vim.api.nvim_set_hl(0, "AgendaRed", { fg = Colors[colorscheme].red, bg = Colors[colorscheme].dark_bg })
  end
end

function M.tableHasKey(table, key)
    return table[key] ~= nil
end

return M


