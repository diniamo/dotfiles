function disable --description 'disable runit services'
	for service in $argv
		sudo rm /var/service/$service &>/dev/null || echo "$service is not enabled"
	end
end
