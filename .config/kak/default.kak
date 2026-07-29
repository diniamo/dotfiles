set-face global PrimaryCursor black,bright-cyan+fg
set-face global PrimaryCursorEol black,bright-cyan+fg
set-face global PrimarySelection black,bright-black
set-face global SecondaryCursor black,cyan+fg
set-face global SecondaryCursorEol black,cyan+fg
set-face global SecondarySelection black,bright-black

hook global ModeChange (push|pop):.*:insert %{
    set-face window PrimaryCursor black,bright-green+fg
    set-face window PrimaryCursorEol black,bright-green+fg
    set-face window PrimarySelection black,bright-black
    set-face window SecondaryCursor black,green+fg
    set-face window SecondaryCursorEol black,green+fg
    set-face window SecondarySelection black,bright-black
}
hook global ModeChange (push|pop):insert:.* %{
    unset-face window PrimaryCursor
    unset-face window PrimaryCursorEol
    unset-face window PrimarySelection
    unset-face window SecondaryCursor
    unset-face window SecondaryCursorEol
    unset-face window SecondarySelection
}

