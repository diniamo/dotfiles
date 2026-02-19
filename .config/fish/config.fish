if status is-interactive
    # -U is slightly faster than -g
    if not set -q fish_configured
        set -U fish_configured
        set -U fish_greeting
        set -U fish_transient_prompt 1

        set -U fish_color_command brgreen
        set -U fish_color_param brwhite
        set -U fish_color_end blue

        set -U fish_cursor_insert line
        set -U fish_cursor_replace_once underscore
        set -U fish_cursor_replace underscore
        set -U fish_cursor_external line

        set -Ux EDITOR kak
        set -Ux PAGER less
    end

    set -gxa PATH ~/.local/bin


    bind ctrl-z fg
    bind --erase ctrl-shift-z
    bind ctrl-y undo
    bind ctrl-shift-y redo

    bind alt-n history-prefix-search-forward
    bind alt-p history-prefix-search-backward

    bind ctrl-g expand-abbr
    bind ctrl-space accept-autosuggestion and execute
    bind ctrl-enter 'commandline $history[1] && commandline -f execute'
    bind tab 'if commandline -P; commandline -f complete; else; commandline -f complete-and-search; end'


    alias tm 'trash-put'

    alias ls 'eza --git --icons --group-directories-first'
    alias la 'ls --almost-all'
    alias l 'ls --long --time-style=long-iso'
    alias ll 'l --almost-all'
    alias lm 'l --sort=age'
    alias llm 'll --sort=age'
    alias lt 'ls --tree'

    alias dot 'git --git-dir ~/.dot --work-tree ~'
    alias dlg 'lazygit --git-dir ~/.dot --work-tree ~'


    abbr --add hash 'sha256sum'
    abbr --add copy 'wl-copy'
    abbr --add paste 'wl-paste'
    abbr --add open 'xdg-open'
    abbr --add size 'du -sh'
    abbr --add '-' 'cd -'
    abbr --add anime 'mpv --profile=anime'
    abbr --add drop 'dragon-drop --all --and-exit'
    abbr --add k kak

    abbr --add install 'sudo xbps-install -y'
    abbr --add remove 'sudo xbps-remove -Ry'
    abbr --add query 'xbps-query'
    abbr --add reconfigure 'sudo xbps-reconfigure'

    abbr --add g 'git'
    abbr --add lg 'lazygit'
    abbr --add ga 'git add'
    abbr --add gc 'git commit'
    abbr --add gd 'git diff'
    abbr --add gl 'git log'
    abbr --add gst 'git status'
    abbr --add grhh 'git reset --hard'
    abbr --add gb 'git branch'
    abbr --add gbc 'git branch --show-current'
    abbr --add gs 'git switch'
    abbr --add gsc 'git switch --create'
    abbr --add gm 'git merge'
    abbr --add gco 'git checkout'
    abbr --add gf 'git fetch'
    abbr --add gfa 'git fetch --all'
    abbr --add gp 'git pull'
    abbr --add gP 'git push'
    abbr --add gpf 'git push --force-with-lease'

    abbr --add command --regex '\\\\.*' --function _prepend_command
    abbr --add !! --position anywhere --function _last_history_entry


    zoxide init --cmd j fish | source
end
