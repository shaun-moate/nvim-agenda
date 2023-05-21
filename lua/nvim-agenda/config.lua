local Colors = require("nvim-agenda.colors")

local M = {}

M.namespace = vim.api.nvim_create_namespace("nvim-agenda")
M.options = {}

local defaults = {
  keywords = {
    SUSPEND = { icon = " ", color = "red" },
    TODO = { icon = " ", color = "orange" },
    FOCUS = { icon = "󱠇 ", color = "yellow" },
    DONE = { icon = " ", color = "green" },
  },
  pattern = [[\KEYWORDS]],
  signs = true,
  signs_priority = 99,
  theme = "gruvbox",
  throttle = 200,
}

function M.setup()
  M.options = vim.tbl_deep_extend("force", {}, defaults)

  local function tags(keywords)
    local kws = keywords or vim.tbl_keys(M.options.keywords)
    table.sort(kws, function(a, b)
      return #b < #a
    end)
    return table.concat(kws, "|")
  end

  function M.search_regex(keywords)
    return M.options.search.pattern:gsub("KEYWORDS", tags(keywords))
  end

  M.hl_regex = {}
  local patterns = M.options.pattern
  patterns = type(patterns) == "table" and patterns or { patterns }
  for _, p in pairs(patterns) do
    p = p:gsub("KEYWORDS", tags())
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
    vim.api.nvim_set_hl(0, "green",  { fg = Colors[colorscheme].green, bg = Colors[colorscheme].dark_bg })
    vim.api.nvim_set_hl(0, "yellow", { fg = Colors[colorscheme].yellow, bg = Colors[colorscheme].dark_bg })
    vim.api.nvim_set_hl(0, "orange", { fg = Colors[colorscheme].orange, bg = Colors[colorscheme].dark_bg })
    vim.api.nvim_set_hl(0, "red", { fg = Colors[colorscheme].red, bg = Colors[colorscheme].dark_bg })
  end
end

function M.tableHasKey(table, key)
    return table[key] ~= nil
end


return M


