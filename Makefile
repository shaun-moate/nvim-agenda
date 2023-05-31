test:
	nvim --headless -c "PlenaryBustedFile tests/nvim_agenda_spec.lua"

lint:
	luacheck lua/nvim-agenda

style:
	stylua --color always --check lua/nvim-agenda

ci/test:
	nvim --headless --noplugin -u scripts/minimal_init.vim -c "PlenaryBustedDirectory tests/ { minimal_init = './scripts/minimal_init.vim' }"

ci/lint:
	luacheck lua/nvim-agenda

ci/style:
	stylua --color always --check lua/nvim-agenda
