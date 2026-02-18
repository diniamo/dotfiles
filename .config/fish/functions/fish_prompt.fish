function fish_prompt
    [ $status = 0 ] && set -f prompt_color brgreen || set -f prompt_color red
    set -f prompt "$(set_color $prompt_color)❱ $(set_color normal)"

    if contains -- --final-rendering $argv
        echo $prompt
        return
    end

    if [ $PWD = / ]
        set -f pwd "$(set_color --bold blue)/$(set_color normal)"
    else
        set -l pwd (prompt_pwd --dir-length 0)

        if [ $pwd = \~ ]
            set -f pwd "$(set_color --bold blue)~$(set_color normal)"
        else
            set -l components (string split / $pwd)
            set -l parent (string join / $components[..-2])
            set -f pwd "$(set_color blue)$parent/$(set_color --bold)$components[-1]$(set_color normal)"
        end
    end

    echo -n "
$pwd
$prompt"
end
