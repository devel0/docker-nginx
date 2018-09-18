#!/bin/bash

source /scripts/constants
source /scripts/utils.sh
exdir=`executing_dir`

container=nginx
container_image=searchathing/nginx
container_data=/nas/data/nginx
net=nginx
ip="$ip_nginx_srv"
cpus="3"
memory="384m"

dk-rm-if-exists $container

certs="/etc/letsencrypt/live/srv0.example.com"

if [ ! -e "$certs/fullchain.pem" ]; then echo not found cert [$certs/fullchain.pem]; fi

docker run \
        -d \
        --name "$container" \
	--hostname "$container" \
	--network="$net" \
        --ip=$ip \
        --restart="unless-stopped" \
        --cpus="$cpus" \
        --memory="$memory" \
        --volume="$container_data/nginx.conf:/etc/nginx/nginx.conf" \
	--volume="$container_data/conf.d:/etc/nginx/conf.d" \
	--volume="/nas/data/nginx/logs:/logs" \
        --volume="/nas/web:/var/www/html" \
	--volume="$certs/fullchain.pem:/etc/ssl/certs/srv0.example.com.crt:ro" \
	--volume="$certs/privkey.pem:/etc/ssl/private/srv0.example.com.key:ro" \
	--volume="$exdir/entrypoint.sh:/var/lib/docker/$container/entrypoint.sh" \
	--volume="/security/htpasswd:/htpasswd" \
	--entrypoint="/var/lib/docker/$container/entrypoint.sh" \
        "$container_image"
