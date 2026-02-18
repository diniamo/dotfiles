function down-or-prefix-search --description 'move down or prefix search forward'
    if commandline --search-mode
        commandline -f history-search-forward
        return
    end
    if commandline --paging-mode
        commandline -f down-line
        return
    end

    set -l line (commandline --line)
    set -l line_count (count (commandline))
    if [ $line = $line_count ]
        commandline -f history-prefix-search-forward
    else
        commandline -f down-line
    end
end
