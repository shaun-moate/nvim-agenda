local M = {}

M.namespace = vim.api.nvim_create_namespace("nvim-agenda")
M.options = {}

local defaults = {
  signs = true,
  signs_priority = 99,
  keywords = {
    TODO = { icon = " ", color = "hint", alt = { "INFO" } },
    DONE = { icon = " ", color = "info" },
  },
  pattern = [[\KEYWORDS]],
  throttle = 200,
}

function M.setup()
  M.options = vim.tbl_deep_extend("force", {}, defaults, M.options or {}, M._options or {})

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

  M.signs()
  require("nvim-agenda.highlight").start()
  M.loaded = true
end

function M.signs()
  for kw, opts in pairs(M.options.keywords) do
    vim.fn.sign_define("agenda-sign-" .. kw, {
      text = opts.icon,
      texthl = "AgendaSign" .. kw,
    })
  end
end

return M


