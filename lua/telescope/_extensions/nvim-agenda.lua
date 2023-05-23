local err, telescope = pcall(require, "telescope")
if not err then
  error("Please install nvim-telescope/telescope with your preferred package manager, it is required for full functionality")
end

local Config = require("nvim-agenda.config")
local builtin = require("telescope.builtin")

local function find_lines()
  local opts = {}

  local keywords =  Config.tags(Config.options.find_lines_keywords)
  opts.prompt_title = "nvim-agenda: find lines"
  opts.search = keywords
  opts.shorten_path = true
  builtin.grep_string(opts)
end

return telescope.register_extension({ exports = { ["nvim-agenda"] = find_lines, find_lines = find_lines } })

