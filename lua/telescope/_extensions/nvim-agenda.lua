local err, telescope = pcall(require, "telescope")
if not err then
	error(
		"Please install nvim-telescope/telescope with your preferred package manager, it is required for full functionality"
	)
end

local Config = require("nvim-agenda.config")
local Utils = require("nvim-agenda.utils")
local builtin = require("telescope.builtin")
local make_entry = require("telescope.make_entry")

local function find_lines(opts)
	opts = opts or {}
	local keywords = Config.tags(ParseArgs(opts.find))

	opts.prompt_title = "nvim-agenda: find lines"
	opts.search = keywords
	opts.shorten_path = true

	local entry_maker = make_entry.gen_from_vimgrep(opts)
	opts.entry_maker = function(line)
		local ret = entry_maker(line)
		ret.display = function(entry)
			local display = string.format("%s:%s:%s ", entry.filename, entry.lnum, entry.col)
			local text = entry.text
			local kw = Utils.match_keyword(text)
			local hl = {}

			if kw then
				local icon = Config.options.keywords[kw].icon
				display = icon .. " " .. kw .. " " .. display
				table.insert(hl, { { 1, #icon }, Config.options.keywords[kw].telescope_color })
				table.insert(hl, { { #icon + 1, #icon + #kw + 1 }, Config.options.keywords[kw].telescope_color })
			end

			return display, hl
		end
		return ret
	end
	builtin.grep_string(opts)
end

function ParseArgs(kw_list)
  assert(type(kw_list) == "string", "'find=' must be present and passed string type and comma-delimited if a list")
  local all_keywords = vim.tbl_keys(Config.options.keywords)
  local filter = vim.split(kw_list, ",")

  return vim.tbl_filter(function(kw)
      return vim.tbl_contains(filter, kw)
    end, all_keywords)
end

return telescope.register_extension({ exports = { ["nvim-agenda"] = find_lines, find_lines = find_lines } })
