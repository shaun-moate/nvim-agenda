test:
	nvim --headless --noplugin -u scripts/minimal_init.vim -c "PlenaryBustedDirectory tests/ { minimal_init = './scripts/minimal_init.vim' }"

lint:
	luacheck lua/nvim-agenda

style:
	stylua --color always --check lua/nvim-agenda
