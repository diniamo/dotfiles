function fish_right_prompt
    if [ $CMD_DURATION -gt 1000 ]
        set -l secs (math --scale=0 $CMD_DURATION/1000 % 60)
        set -l mins (math --scale=0 $CMD_DURATION/60000 % 60)
        set -l hours (math --scale=0 $CMD_DURATION/3600000)

        [ $hours -gt 0 ] && set -fa time $hours'h'
        [ $mins  -gt 0 ] && set -fa time $mins'm'
        [ $secs  -gt 0 ] && set -fa time $secs's'

        set -q time && echo -n (set_color brblack)$time(set_color normal)
    end
end
