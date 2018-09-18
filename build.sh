#!/bin/bash

source /scripts/constants
source /scripts/utils.sh
exdir=`executing_dir`

container_image=searchathing/nginx

if [ ! -e /etc/letsencrypt ]; then
	echo "please install letsencrypt"
	exit 1
fi

user_id nginx
if [ "$?" != "0" ]; then
	echo "creating nginx user"
	useradd nginx
fi

# regen Dockerfile

cat << EOF > "$exdir"/Dockerfile
# ---
# DO NO EDIT THIS !
#
# File was generated from image_build.sh and Dockerfile.tmpl
#
EOF

www_data_gid=`group_id www-data`
www_data_uid=`user_id www-data`
nginx_gid=`group_id nginx`
nginx_uid=`user_id nginx`

cat "$exdir"/Dockerfile.tmpl \
	| sed s/\$www_data_gid[\$]/"$www_data_gid"/g \
	| sed s/\$www_data_uid[\$]/"$www_data_uid"/g \
	| sed s/\$nginx_gid[\$]/"$nginx_gid"/g \
	| sed s/\$nginx_uid[\$]/"$nginx_uid"/g \
	>> "$exdir"/Dockerfile

docker build --network=build -t $container_image "$exdir"
