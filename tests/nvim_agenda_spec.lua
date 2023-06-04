describe("nvim-agenda", function()

  -- Globals
  it("nvim-agenda can be required", function()
    require("nvim-agenda")
  end)

  -- Highlight ("nvim-agenda.highlight")
  it("highlight: can be required", function()
    require("nvim-agenda.highlight")
  end)

  -- Toggle ("nvim-agenda.toggle")
  it("toggle: check_keyword correctly recognises default keyword", function()
    local res = require("nvim-agenda.toggle").check_keyword("to=TODO")
    assert(res)
  end)

  -- Config ("nvim-agenda.config")
  it("config: can be required", function()
    require("nvim-agenda.config")
  end)

  -- Utils ("nvim-agenda.utils")
  it("utils: match_keyword correctly recognises default keyword", function()
    local res = require("nvim-agenda.utils").match_keyword("-- TODO")
    assert(res)
  end)

  -- Colors ("nvim-agenda.colors")
  it("colors: default theme can be found in the table", function()
    local res = require("nvim-agenda.colors").default
    assert(res)
  end)

  it("colors: gruvbox theme can be found in the table", function()
    local res = require("nvim-agenda.colors").gruvbox
    assert(res)
  end)

end)
