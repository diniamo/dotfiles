function fish_user_key_bindings
	bind ctrl-backspace backward-kill-word
	bind ctrl-delete kill-word
	bind ctrl-left backward-word
	bind ctrl-right forward-word

    bind ctrl-z fg
    bind --erase ctrl-shift-z
    bind ctrl-y undo
    bind ctrl-shift-y redo

    bind ctrl-n down-or-prefix-search
    bind ctrl-p up-or-prefix-search
    bind alt-n history-token-search-forward
    bind alt-p history-token-search-backward

    bind ctrl-g expand-abbr
    bind ctrl-space accept-autosuggestion and execute
    bind ctrl-enter 'commandline $history[1] && commandline -f execute'
    bind tab 'commandline --paging-mode && commandline -f complete || commandline -f complete-and-search'
end
