command! -nargs=* AgendaTelescope Telescope nvim-agenda find_lines <args>
command! -nargs=* AgendaToggle lua require("nvim-agenda.toggle").toggle(<q-args>)
