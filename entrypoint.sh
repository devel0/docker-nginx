#!/bin/bash

container=nginx
dockerlib=/var/lib/docker/"$container"

mkdir -p "$dockerlib"

entrypoint_executed_file="$dockerlib"/entrypoint-executed

# container vars
wwwfld=/var/www/html
wwwuser=nginx

if [ ! -f "$entrypoint_executed_file" ]; then
	#=========================================================================
	#
	# initial build script
	#
	#=========================================================================

	echo "init"

	echo "nameserver 172.18.0.2" > /etc/resolv.conf
	echo "search example.com" >> /etc/resolv.conf

	touch "$entrypoint_executed_file"
fi

#=========================================================================
#
# every run script
#
#=========================================================================

echo "start"

# recall the original CMD,ENTRYPOINT
nginx -g "daemon off;"
