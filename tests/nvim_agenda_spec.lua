describe("nvim-agenda", function()

  -- Globals
  it("nvim-agenda can be required", function()
    require("nvim-agenda")
  end)

  -- Highlight ("nvim-agenda.highlight")
  it("highlight: can be required", function()
    require("nvim-agenda.highlight")
  end)

  -- Config ("nvim-agenda.config")
  it("config: can be required", function()
    require("nvim-agenda.config")
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
