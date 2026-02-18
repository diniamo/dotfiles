function up-or-prefix-search --description 'move up or prefix search backward'
    if commandline --search-mode
        commandline -f history-search-backward
        return
    end
    if commandline --paging-mode
        commandline -f up-line
        return
    end

    set -l line (commandline --line)
    if [ $line = 1 ]
        commandline -f history-prefix-search-backward
    else
        commandline -f up-line
    end
end
