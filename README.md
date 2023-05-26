# nvim-agenda

## Description
I have a lot in my head, and want to get it out.  I have tried using Emacs, ended up being not for me.  I want to use Vim.  I appreciated the power of Org-Agenda.  I would like to bring some of that functionality to Vim.  Key areas I would like covered:
 - keyword highlighting :white_check_mark:
 - search functionality :white_check_mark: 
 - toggle keywords 
 - set a priorities
 - archive completed tasks
 - add repeat tasks
 - schedule tasks

With the above functionality I hope to stay on top and easily manage tasks - ensuring I don't lose ideas tragically becuase I just didn't quickly jot them down.


## Requirements
Best with Telescope and a patched font installed


## How to Install
** __tbd__ on package manager (still learning lua and vim plugins!) **

Easily install it locally
```lua
vim.opt.runtimepath:append([/PATH/TO/PROJECT])

require'nvim-agenda'.setup({
  <insert your configuration options>
})
```

nvim-agenda comes with default configuration that you can override
```lua
{
  find_lines_keywords = { "TODO" },                  -- keywords to search for when using AgendaTelescope
  keywords = {
    TODO = { icon = " ", color = "AgendaYellow" },  -- keywords with patch font icon and colorscheme
    DONE = { icon = " ", color = "AgendaGreen" },
  },
  signs = true,                                      -- toggle to show icons  
  signs_priority = 99,                               -- priority of icons
  throttle = 200,                                    -- throttle for highlight loop
  pattern = [[\KEYWORDS]],                           -- vim grep search pattern
}
```

An example configuration at setup could be as follows
```lua
vim.opt.runtimepath:append([/home/user/code/nvim-agenda])

require'nvim-agenda'.setup({
  keywords = {
    SUSPEND = { icon = "󱍥 ", color = "AgendaRed" },
    TODO = { icon = " ", color = "AgendaYellow" },
    FOCUS = { icon = "󰈸 ", color = "AgendaOrange" },
    DONE = { icon = " ", color = "AgendaGreen" },
  },
  theme = "gruvbox",
  find_lines_keywords = { "SUSPEND", "TODO", "FOCUS" }
})

-- set up keymap for easy access to AgendaTelescope
vim.api.nvim_set_keymap("n", "ft", ":AgendaTelescope<CR>", {})
```


## How to Use
### 🔭 `:AgendaTelescope`
Search through all project configured keywords with Telescope


## Credits
Inspiration: Org-Agenda, TJ DeVries and [folke/todo-comments](https://github.com/folke/todo-comments.nvim/tree/main)
