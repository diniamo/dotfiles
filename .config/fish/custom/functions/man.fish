function man --description='view man page in Kakoune'
	if [ (count $argv) -gt 1 ]
		set -f page "$argv[2]($argv[1])"
	else
		set -f page $argv[1]
	end

	kak -e "man $page"
end
