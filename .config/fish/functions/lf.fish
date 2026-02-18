function lf --wraps lf --description 'follow lf'
    cd (command lf -print-last-dir $argv)
end
