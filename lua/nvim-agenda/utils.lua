local Config = require "nvim-agenda.config"

local M = {}
M.states = {}
M.buffers = {}

function M.match_keyword(string)
	local pattern = Config.hl_regex[1]
	local match = vim.fn.matchstrpos(string, [[\v\C]] .. pattern)

	if match[1] ~= "" then
		return match[1], match[2], match[3]
	end
end

function M.is_valid_window(windowId)
	if not vim.api.nvim_win_is_valid(windowId) then
		return false
	end
	-- avoid E5108 after pressing q:
	if vim.fn.getcmdwintype() ~= "" then
		return false
	end
	-- dont do anything for floating windows
	if M.is_floating_window(windowId) then
		return false
	end
	local bufferId = vim.api.nvim_win_get_buf(windowId)
	return M.is_valid_buffer(bufferId)
end

function M.is_floating_window(windowId)
	local opts = vim.api.nvim_win_get_config(windowId)
	return opts and opts.relative and opts.relative ~= ""
end

function M.is_valid_buffer(bufferId)
	-- Skip special buffers
	local buftype = vim.api.nvim_buf_get_option(bufferId, "buftype")
	if buftype ~= "" and buftype ~= "quickfix" then
		return false
	end
	return true
end

return M
