function man --wraps man --description='view man page in Kakoune'
	if [ (count $argv) -gt 1 ]
		set -f page "$argv[2]($argv[1])"
	else
		set -f page $argv[1]
	end

	kak -ro -e "try %{ man '$page' } catch %{ quit 1 }" || {
		echo "$page not found" 1>&2
		return 1
	}
end
