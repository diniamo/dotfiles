complete --command enable --no-files --arguments "(for service in (command ls /etc/sv); test -e /var/service/\$service || echo \$service; end)"
