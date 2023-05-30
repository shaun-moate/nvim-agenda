local M = {}

function M.setup(customOptions)
	require("nvim-agenda.config")._setup(customOptions)
end

function M.enable()
	require("nvim-agenda.highlight").start()
end

function M.disable()
	require("nvim-agenda.highlight").stop()
end

return M
