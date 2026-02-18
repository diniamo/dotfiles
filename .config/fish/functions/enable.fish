function enable --description 'enable runit services'
	for service in $argv
		if [ -e /etc/sv/$service ]
			sudo ln -s /etc/sv/$service /var/service/$service || echo "$service is already enabled"
		else
			echo "$service does not exist"
		end
	end
end
