function .. --argument-names n --description 'go up n directories'
    if set -q n
        cd (string repeat -Nn $argv[1] ../)
    else
        cd ..
    end
end
