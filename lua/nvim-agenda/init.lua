-- TODO implement a setup function that takes in {opts} and kicks off nvim-agenda
local M = {}

function M.setup()
  require("nvim-agenda.config").setup()
end

function M.enable()
  require"nvim-agenda.highlight".start()
end

function M.disable()
  require"nvim-agenda.highlight".stop()
end

return M
