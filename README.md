# nvim-agenda

## Description
I have a lot in my head, and want to get it out.  I have tried using Emacs, ended up being not for me.  I want to use Vim.  I appreciated the power of Org-Agenda.  I would like to bring some of that functionality to Vim.  Key areas I would like covered:
 - keyword highlighting :white_check_mark:
 - search functionality :white_check_mark: 
 - toggle keywords :white_check_mark: 
 - archive 'DONE' tasks

With the above functionality I hope to stay on top and easily manage tasks - ensuring I don't lose ideas tragically becuase I just didn't quickly jot them down.


## Requirements
Best with Telescope and a patched font installed


## Installation

Using plug:
```lua
Plug 'shaun-moate/nvim-agenda'
```

Using Packer:
```lua
use 'shaun-moate/nvim-agenda'
```

Using lazy:
```lua
require('nvim-agenda').setup()
```

## Configuration
nvim-agenda comes with default configuration that you can override
```lua
{
  keywords = {                                       -- keywords with patch font icon and colorscheme
    TODO = { 
      icon = " ", 
      color = "AgendaYellow",                        
      telescope_color = "AgendaYellowTransparentBg"
      },  
    DONE = { 
      icon = " ", 
      color = "AgendaGreen",
      telescope_color = "AgendaGreenTransparentBg"
      },
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
    SUSPEND = { 
      icon = "󱍥 ", 
      color = "AgendaRed" 
      telescope_color = "AgendaRedTransparentBg"
      },
    TODO = { 
      icon = " ", 
      color = "AgendaYellow" 
      telescope_color = "AgendaYellowTransparentBg"
      },
    FOCUS = { 
      icon = "󰈸 ", 
      color = "AgendaOrange" 
      telescope_color = "AgendaOrangeTransparentBg"
      },
    DONE = { 
      icon = " ", 
      color = "AgendaGreen" 
      telescope_color = "AgendaGreenTransparentBg"
      },
  },
  telescope_keywords = { "SUSPEND", "TODO", "FOCUS" },
  theme = "gruvbox",
})

-- set up keymap for easy access to AgendaTelescope
vim.api.nvim_set_keymap("n", "ft", ":AgendaTelescope find=TODO<CR>", {})
vim.api.nvim_set_keymap("n", "mtt", ":AgendaToggle to=TODO<CR>", {})
vim.api.nvim_set_keymap("n", "mtd", ":AgendaToggle to=DONE<CR>", {})
```


## How to Use
### `:AgendaTelescope`
Search through all project configured keywords with Telescope


### `:AgendaToggle to=<insert-keyword>`
Toggle a keyword on the current line to the provided keyword (MUST BE CONFIGURED KEYWORDS)


## Credits
Inspiration: Org-Agenda, TJ DeVries and [folke/todo-comments](https://github.com/folke/todo-comments.nvim/tree/main)
