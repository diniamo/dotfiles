define-command _set-cursor-style -params 1 -docstring 'set Alacritty cursor style' %{
	nop %sh{
		printf "\033[%d q" "$1" >/proc/$kak_client_pid/fd/1
	}
}

set-option -add global ui_options terminal_cursor_native=yes
hook global ClientCreate .* %{ _set-cursor-style 2 }
hook global ClientClose .* %{ _set-cursor-style 0 }

unset-face global PrimaryCursor
unset-face global PrimaryCursorEol
unset-face global StatusCursor
set-face global PrimarySelection black,bright-black
set-face global SecondaryCursor black,cyan+fg
set-face global SecondaryCursorEol black,cyan+fg
set-face global SecondarySelection black,bright-black
hook global ModeChange (push|pop):.*:insert %{
    _set-cursor-style 0

    set-face window PrimarySelection black,bright-black
    set-face window SecondaryCursor black,green+fg
    set-face window SecondaryCursorEol black,green+fg
    set-face window SecondarySelection black,bright-black
}
hook global ModeChange (push|pop):insert:.* %{
    _set-cursor-style 2

    unset-face window PrimarySelection
    unset-face window SecondaryCursor
    unset-face window SecondaryCursorEol
    unset-face window SecondarySelection
}
