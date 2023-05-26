local Config = require("nvim-agenda.config")
local Utils = require("nvim-agenda.utils")

local M = {}
M.states = {}
M.windows = {}
M.buffers = {}

function M.highlight(buffer, first, last)
  local lines = vim.api.nvim_buf_get_lines(buffer, first, last + 1, false)

  M.remove_signs()
  for l, line in ipairs(lines) do
    local kw, start, finish = Utils.match_keyword(line)
    local line_number = first + l - 1

    if kw ~= nil then
      local show_sign = Config.options.signs
      if show_sign then
        vim.fn.sign_place(
          0,
          "agenda-signs",
          "agenda-sign-" .. kw,
          buffer,
          { lnum = line_number + 1, priority = Config.options.signs_priority }
        )
      end
      vim.api.nvim_buf_add_highlight(buffer, 0, Config.options.keywords[kw].color, line_number, start, finish)
    end
  end
end

function M.highlight_window(windowId)
  local window = windowId or vim.api.nvim_get_current_win()
  local current_buffer = vim.api.nvim_win_get_buf(window)
  local first_line = vim.fn.line("w0") - 1
  local last_line = vim.fn.line("w$")

  M.set_state(current_buffer, first_line, last_line)
  M.highlight(current_buffer, first_line, last_line)
end

function M.set_state(bufferId, first_line, last_line)
  local state = M.get_state(bufferId)

  for i = first_line, last_line do
    state[i] = true
  end
end

function M.get_state(bufferId)
  if not M.states[bufferId] then
    M.states[bufferId] = {}
  end
  return M.states[bufferId]
end

function M.attach(windowId)
  local window = windowId or vim.api.nvim_get_current_win()
  if not Utils.is_valid_window(window) then
    return
  end

  local buffer = vim.api.nvim_get_current_buf()
  if not M.buffers[buffer] then
    vim.api.nvim_buf_attach(buffer, false, {
      on_lines = function(_event, _buf, _tick, first, _last, last_new)
        if not M.enabled then
          return true
        end
        -- detach from this buffer in case we no longer want it
        if not Utils.is_valid_buffer(buffer) then
          return true
        end

        M.set_state(buffer, first, last_new)
      end,
      on_detach = function()
        M.states[buffer] = nil
        M.buffers[buffer] = nil
      end,
    })

    local highlighter = require("vim.treesitter.highlighter")
    local hl = highlighter.active[buffer]
    if hl then
      hl.tree:register_cbs({
        on_bytes = function(_, _, row)
          M.set_state(buffer, row, row + 1)
        end,
        on_changedtree = function(changes)
          for _, ch in ipairs(changes or {}) do
            M.set_state(buffer, ch[1], ch[3] + 1)
          end
        end,
      })
    end

    M.buffers[buffer] = true
    M.windows[window] = true
  elseif not M.windows[window] then
    M.windows[window] = true
  end
  M.highlight_window(window)
end

function M.start()
  if M.enabled then
    M.stop()
  end
  M.enabled = true
  vim.api.nvim_exec(
    [[augroup Todo
        autocmd!
        autocmd BufEnter,BufWinEnter * lua require("nvim-agenda.highlight").attach()
        autocmd WinScrolled,BufWritePost * lua require("nvim-agenda.highlight").highlight_window()
      augroup end]],
    false
  )

  for _, win in pairs(vim.api.nvim_list_wins()) do
    M.attach(win)
  end
end

function M.stop()
  M.enabled = false
  pcall(vim.cmd, "autocmd! Agenda")
  pcall(vim.cmd, "augroup! Agenda")
  M.windows = {}

  M.remove_signs()
  M.buffers = {}
end

function M.remove_signs()
  vim.fn.sign_unplace("agenda-signs")
  for buf, _ in pairs(M.buffers) do
    if vim.api.nvim_buf_is_valid(buf) then
      pcall(vim.api.nvim_buf_clear_namespace, buf, Config.namespace, 0, -1)
    end
  end
end

return M
